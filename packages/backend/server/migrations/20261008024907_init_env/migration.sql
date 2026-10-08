/*
  Warnings:

  - You are about to drop the column `tokenCost` on the `ai_sessions_metadata` table. All the data in the column will be lost.
  - You are about to drop the column `strategy` on the `ai_transcript_tasks` table. All the data in the column will be lost.
  - You are about to drop the `ai_prompts_messages` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `ai_prompts_metadata` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `ai_workspace_blob_embeddings` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `ai_workspace_file_embeddings` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `ai_workspace_files` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `pending_license_deactivations` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `workspace_sync_permission_generations` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "ai_message_artifacts" DROP CONSTRAINT "ai_message_artifacts_message_id_fkey";

-- DropForeignKey
ALTER TABLE "ai_message_artifacts" DROP CONSTRAINT "ai_message_artifacts_workspace_id_artifact_id_fkey";

-- DropForeignKey
ALTER TABLE "ai_prompts_messages" DROP CONSTRAINT "ai_prompts_messages_prompt_id_fkey";

-- DropForeignKey
ALTER TABLE "ai_workspace_blob_embeddings" DROP CONSTRAINT "ai_workspace_blob_embeddings_workspace_id_blob_id_fkey";

-- DropForeignKey
ALTER TABLE "ai_workspace_file_embeddings" DROP CONSTRAINT "ai_workspace_file_embeddings_workspace_id_file_id_fkey";

-- DropForeignKey
ALTER TABLE "ai_workspace_files" DROP CONSTRAINT "ai_workspace_files_workspace_id_fkey";

-- DropForeignKey
ALTER TABLE "workspace_artifacts" DROP CONSTRAINT "workspace_artifacts_workspace_id_fkey";

-- DropForeignKey
ALTER TABLE "workspace_sync_permission_generations" DROP CONSTRAINT "workspace_sync_permission_generations_workspace_id_fkey";

-- DropIndex
DROP INDEX "calendar_subscriptions_sync_claim_idx";

-- DropIndex
DROP INDEX "workspace_invitations_inviter_created_at_idx";

-- DropIndex
DROP INDEX "workspace_invitations_inviter_status_created_at_idx";

-- DropIndex
DROP INDEX "workspace_invitations_workspace_accepted_at_idx";

-- DropIndex
DROP INDEX "workspace_invitations_workspace_inviter_created_at_idx";

-- DropIndex
DROP INDEX "workspace_invitations_workspace_status_created_at_idx";

-- DropIndex
DROP INDEX "workspace_members_workspace_state_created_at_idx";

-- AlterTable
ALTER TABLE "ai_sessions_metadata" DROP COLUMN "tokenCost";

-- AlterTable
ALTER TABLE "ai_transcript_tasks" DROP COLUMN "strategy";

-- AlterTable
ALTER TABLE "blobs" ALTER COLUMN "reservation_id" DROP NOT NULL;

-- AlterTable
ALTER TABLE "comment_attachments" ALTER COLUMN "reservation_id" DROP NOT NULL;

-- AlterTable
ALTER TABLE "payment_events" ALTER COLUMN "updated_at" DROP DEFAULT;

-- AlterTable
ALTER TABLE "provider_subscriptions" ALTER COLUMN "updated_at" DROP DEFAULT;

-- AlterTable
ALTER TABLE "subscription_trial_usages" ALTER COLUMN "updated_at" DROP DEFAULT;

-- AlterTable
ALTER TABLE "workspace_artifacts" ALTER COLUMN "updated_at" DROP DEFAULT;

-- DropTable
DROP TABLE "ai_prompts_messages";

-- DropTable
DROP TABLE "ai_prompts_metadata";

-- DropTable
DROP TABLE "ai_workspace_blob_embeddings";

-- DropTable
DROP TABLE "ai_workspace_file_embeddings";

-- DropTable
DROP TABLE "ai_workspace_files";

-- DropTable
DROP TABLE "pending_license_deactivations";

-- DropTable
DROP TABLE "workspace_sync_permission_generations";

-- AddForeignKey
ALTER TABLE "workspace_artifacts" ADD CONSTRAINT "workspace_artifacts_workspace_id_fkey" FOREIGN KEY ("workspace_id") REFERENCES "workspaces"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ai_message_artifacts" ADD CONSTRAINT "ai_message_artifacts_message_id_fkey" FOREIGN KEY ("message_id") REFERENCES "ai_sessions_messages"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ai_message_artifacts" ADD CONSTRAINT "ai_message_artifacts_workspace_id_artifact_id_fkey" FOREIGN KEY ("workspace_id", "artifact_id") REFERENCES "workspace_artifacts"("workspace_id", "id") ON DELETE CASCADE ON UPDATE CASCADE;

-- RenameIndex
ALTER INDEX "comment_attachments_workspace_id_status_deleted_at_reservation_" RENAME TO "comment_attachments_workspace_id_status_deleted_at_reservat_idx";

-- RenameIndex
ALTER INDEX "provider_subscriptions_revenuecat_external_identity_key" RENAME TO "provider_subscriptions_provider_iap_store_external_ref_exte_key";
