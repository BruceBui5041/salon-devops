# -----------------------------------------------------------------------------
# App
# -----------------------------------------------------------------------------
DISABLE_ESLINT_PLUGIN=true
BASEPATH=
NEXT_PUBLIC_APP_URL=http://${PUBLIC_IP}:3000${BASEPATH}
NEXT_PUBLIC_DOCS_URL=https://demos.pixinvent.com/materialize-nextjs-admin-template/documentation

# -----------------------------------------------------------------------------
# Authentication (NextAuth.js)
# -----------------------------------------------------------------------------
NEXTAUTH_BASEPATH=${BASEPATH}/api/auth
NEXTAUTH_URL=http://${PUBLIC_IP}:3000${BASEPATH}/api/auth
NEXTAUTH_SECRET=92I3qVP+/c2aP8fXKyuPejE8m3zSoAwrPcUqSN/1smM=

# Google OAuth 2.0 (https://console.cloud.google.com/apis/credentials)
GOOGLE_CLIENT_ID=
GOOGLE_CLIENT_SECRET=

# -----------------------------------------------------------------------------
# Database
# -----------------------------------------------------------------------------
DATABASE_URL=

# -----------------------------------------------------------------------------
# API
# -----------------------------------------------------------------------------
BASE_HOST_PATH=/api/apps
BE_API_PATH=http://${BE_API}:2888${BASEPATH}
NEXT_PUBLIC_BE_API_PATH=http://${BE_API}:2888${BASEPATH}

# SSR API URL
API_URL=http://${API_URL}${BASEPATH}/api
NEXT_PUBLIC_API_URL=http://${BE_API}:2888${BASEPATH}
