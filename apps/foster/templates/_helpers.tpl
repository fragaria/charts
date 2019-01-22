{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "foster.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "foster.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}

{{- define "foster.migrationjobname" -}}
{{ template "foster.fullname" . }}-migration-job
{{- end -}}

{{- define "foster.dbinitjobname" -}}
{{ template "foster.fullname" . }}-db-init-job
{{- end -}}

{{- define "foster.backupjobname" -}}
{{ template "foster.fullname" . }}-backup-job
{{- end -}}

{{- define "foster.createsuperuserjobname" -}}
{{ template "foster.fullname" . }}-createsuperuser-job
{{- end -}}

{{- define "foster.configmapname" -}}
{{ template "foster.fullname" . }}-env
{{- end -}}

{{- define "foster.pvcname" -}}
{{ template "foster.fullname" . }}-pvc
{{- end -}}

{{- define "proxy.name" -}}
proxy
{{- end -}}

{{- define "proxy.fullname" -}}
{{ template "foster.fullname" . }}-proxy
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "foster.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}
