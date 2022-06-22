Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E35CCCA48A
	for <linux-arch@archiver.kernel.org>; Wed, 22 Jun 2022 15:53:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359689AbiFVPxH (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Wed, 22 Jun 2022 11:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359648AbiFVPwu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 Jun 2022 11:52:50 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33A291EED1;
        Wed, 22 Jun 2022 08:52:47 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LSnqy1ptczSgwk;
        Wed, 22 Jun 2022 23:49:18 +0800 (CST)
Received: from dggpemm500013.china.huawei.com (7.185.36.172) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 22 Jun 2022 23:52:42 +0800
Received: from ubuntu1804.huawei.com (10.67.175.36) by
 dggpemm500013.china.huawei.com (7.185.36.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 22 Jun 2022 23:52:42 +0800
From:   Chen Zhongjin <chenzhongjin@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linuxppc-dev@lists.ozlabs.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kbuild@vger.kernel.org>, <live-patching@vger.kernel.org>
CC:     <jpoimboe@kernel.org>, <peterz@infradead.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <masahiroy@kernel.org>, <michal.lkml@markovi.net>,
        <ndesaulniers@google.com>, <mark.rutland@arm.com>,
        <pasha.tatashin@soleen.com>, <broonie@kernel.org>,
        <chenzhongjin@huawei.com>, <rmk+kernel@armlinux.org.uk>,
        <madvenka@linux.microsoft.com>, <christophe.leroy@csgroup.eu>
Subject: [PATCH v5 04/33] objtool: arm64: Decode jump and call related instructions
Date:   Wed, 22 Jun 2022 23:48:51 +0800
Message-ID: <20220622154920.95075-5-chenzhongjin@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220622154920.95075-1-chenzhongjin@huawei.com>
References: <20220622154920.95075-1-chenzhongjin@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.36]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500013.china.huawei.com (7.185.36.172)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Decode branch, branch and link (aarch64's call) and return instructions.

Signed-off-by: Julien Thierry <jthierry@redhat.com>
Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
---
 tools/objtool/arch/arm64/decode.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/tools/objtool/arch/arm64/decode.c b/tools/objtool/arch/arm64/decode.c
index d8c32703874d..40ada17d0842 100644
--- a/tools/objtool/arch/arm64/decode.c
+++ b/tools/objtool/arch/arm64/decode.c
@@ -212,6 +212,27 @@ int arch_decode_instruction(struct objtool_file *file, const struct section *sec
 			}
 		}
 		break;
+	case AARCH64_INSN_CLS_BR_SYS:
+		if (aarch64_insn_is_ret(insn) &&
+		    aarch64_insn_decode_register(AARCH64_INSN_REGTYPE_RN, insn)
+			== AARCH64_INSN_REG_LR) {
+			*type = INSN_RETURN;
+		} else if (aarch64_insn_is_bl(insn)) {
+			*type = INSN_CALL;
+			*immediate = aarch64_get_branch_offset(insn);
+		} else if (aarch64_insn_is_blr(insn)) {
+			*type = INSN_CALL_DYNAMIC;
+		} else if (aarch64_insn_is_b(insn)) {
+			*type = INSN_JUMP_UNCONDITIONAL;
+			*immediate = aarch64_get_branch_offset(insn);
+		} else if (aarch64_insn_is_br(insn)) {
+			*type = INSN_JUMP_DYNAMIC;
+		} else if (aarch64_insn_is_branch_imm(insn)) {
+			/* Remaining branch opcodes are conditional */
+			*type = INSN_JUMP_CONDITIONAL;
+			*immediate = aarch64_get_branch_offset(insn);
+		}
+		break;
 	default:
 		break;
 	}
-- 
2.17.1

