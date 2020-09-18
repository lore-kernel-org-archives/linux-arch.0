Return-Path: <SRS0=8KsW=C3=vger.kernel.org=linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B360C43464
	for <linux-arch@archiver.kernel.org>; Fri, 18 Sep 2020 13:25:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDF27235FD
	for <linux-arch@archiver.kernel.org>; Fri, 18 Sep 2020 13:25:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbgIRNZ2 (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Fri, 18 Sep 2020 09:25:28 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:40173 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726697AbgIRNZ0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Sep 2020 09:25:26 -0400
Received: from threadripper.lan ([149.172.98.151]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MHVWT-1kF5Nc1ViL-00Dagl; Fri, 18 Sep 2020 15:24:53 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Christoph Hellwig <hch@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Biederman <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        kexec@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 0/4] syscalls: remove compat_alloc_user_space callers
Date:   Fri, 18 Sep 2020 15:24:35 +0200
Message-Id: <20200918132439.1475479-1-arnd@arndb.de>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:UjQjV4ov690MwNa3Q5mCT2pQm83KgkApQ+LHUHo3iIfrCSGo6kQ
 Tv3yP0Ug+LKsRVKpAwZ5lqEUMjx5kGdXz5IviT/i2A9kwjWIfIWS3nK6I2wq9AEbrpnJGtm
 3bcP+bj3xyzV8YXB9SkPa49D/W2OQSca1iw02rHAqsE2SE6zoO+nTXTErqPS8nDlXhPBsAy
 pynRTxg+DXy9h0Tfbstgw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vttkmPiVS0M=:zC3skVXcohC/UFP2E2k7H2
 69CaxXG4WBTGiyxfdAY6lPDjiMy3PbYf9is8RZcD+RDfcdguIhJSIE4uVyaYVBH9UcX8zaRU6
 tHIhm0Hx44+w088aupeRUZPui1Kzq8iOPSCR8T2Cb4mhuuHRFGVeD0Ej6iWfBZ+qIu6tcnyXX
 G56ArS0+Q0E0iidNSAOji47S+p+Z8aFAVJQefda4qsg1StNDRlTEbvR3W6FbyaSCFFJyESOY2
 0PcMtO+4GyIga/XXk3RMpR7Y8v8R8zNNQ9eoRAZc1tm6wZqaQK1zXu/2QhAZwq3NBMrLguY/f
 et8GcBR5lR+HhhR3+3K6yrdSmNUvTrLTVH2SyA4+Kvgaenwc3NeS52DyQu83B0Y28JAnw/fmQ
 OQR5ka/I5Q0jVqtQwuSRsinsWTdHlcdU4lbItwz5Uu1mvqMHv/mm2CB0TX9VnzMoy/NNMMsCI
 fCQPVetQtcZ6/lrafboynZ1oMQ3j1VAuxSusm3YQhOAnZHWMfeGIf+/DYFbajGh4AibhNCk1j
 4WtdP7M4vNDmcgb7eJKm3Xraxkj74THjSoGBA3BSj3h5cLFP4GyEHzYDASPjOoQqpMOxiwldr
 7Zfl/nT9oirISINQhB8m/+bgREoi53hhWBjqYpgGAcPFXbLSBLlCoD8Eq6EZDhLk25b+bklF3
 FgkpBs1tOhG1DcP3GT6CAxlXZWZ/Wlgs1+jE2828QVrsZ4yaJb+TIZJ90d47N7DUPzT003xKR
 0iyMt0JcVDAqZy6njtwuMNGkn33QJSyFiIEtdzzQ8K2knu6JUm59oQjxUdLUtouXUd4dMKrtm
 OjAqDthOvYM5NFI3ESLfx8Qr8kc2HIZ5fgYkdYLVhCEutIi1lWGI6gXEVDXt2pTiXYpn1HK
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Going through compat_alloc_user_space() to convert indirect system call
arguments tends to add complexity compared to handling the native and
compat logic in the same code.

I have patches for all other uses of compat_alloc_user_space() as well,
and would expect that we can subsequently remove the interface itself.

      Arnd

Arnd Bergmann (4):
  x86: add __X32_COND_SYSCALL() macro
  kexec: remove compat_sys_kexec_load syscall
  mm: remove compat_sys_move_pages
  mm: remove compat numa syscalls

 arch/arm64/include/asm/unistd32.h         |  12 +-
 arch/mips/kernel/syscalls/syscall_n32.tbl |  12 +-
 arch/mips/kernel/syscalls/syscall_o32.tbl |  12 +-
 arch/parisc/kernel/syscalls/syscall.tbl   |  10 +-
 arch/powerpc/kernel/syscalls/syscall.tbl  |  12 +-
 arch/s390/kernel/syscalls/syscall.tbl     |  12 +-
 arch/sparc/kernel/syscalls/syscall.tbl    |  12 +-
 arch/x86/entry/syscalls/syscall_32.tbl    |   6 +-
 arch/x86/entry/syscalls/syscall_64.tbl    |   4 +-
 arch/x86/include/asm/syscall_wrapper.h    |   5 +
 include/linux/compat.h                    |  26 ---
 include/uapi/asm-generic/unistd.h         |  12 +-
 kernel/kexec.c                            |  77 +++------
 kernel/sys_ni.c                           |   5 -
 mm/mempolicy.c                            | 193 +++++-----------------
 mm/migrate.c                              |  45 +++--
 16 files changed, 143 insertions(+), 312 deletions(-)

-- 
2.27.0

