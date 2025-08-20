FROM cirrusci/flutter:stable AS build

# Definir o diretório de trabalho
WORKDIR /app

# Copiar os arquivos de configuração do Flutter
COPY pubspec.yaml pubspec.lock ./

# Baixar as dependências
RUN flutter pub get

# Copiar todo o código fonte
COPY . .

# Habilitar o Flutter Web
RUN flutter config --enable-web

# Fazer o build da aplicação web
RUN flutter build web --release

# Usar nginx para servir a aplicação
FROM nginx:alpine

# Copiar os arquivos buildados para o nginx
COPY --from=build /app/build/web /usr/share/nginx/html

# Copiar configuração personalizada do nginx (opcional)
# COPY nginx.conf /etc/nginx/nginx.conf

# Expor a porta 80
EXPOSE 80

# Comando para iniciar o nginx
CMD ["nginx", "-g", "daemon off;"]