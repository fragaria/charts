{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "fcp.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "fcp.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}

{{- define "fcp.migrationjobname" -}}
{{ template "fcp.fullname" . }}-migration-job
{{- end -}}

{{- define "fcp.backupjobname" -}}
{{ template "fcp.fullname" . }}-backup-job
{{- end -}}

{{- define "fcp.createsuperuserjobname" -}}
{{ template "fcp.fullname" . }}-createsuperuser-job
{{- end -}}

{{- define "fcp.configmapname" -}}
{{ template "fcp.fullname" . }}-env
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "fcp.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "postgresql.name" -}}postgresql{{- end -}}

{{- define "postgresql.fullname" -}}
{{- printf "%s-%s" .Release.Name "postgresql" | trunc 63 | trimSuffix "-" -}}
{{- end -}}
