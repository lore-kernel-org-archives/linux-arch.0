Return-Path: <SRS0=x4yw=EF=vger.kernel.org=linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EDE3C55178
	for <linux-arch@archiver.kernel.org>; Fri, 30 Oct 2020 16:30:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFB0922241
	for <linux-arch@archiver.kernel.org>; Fri, 30 Oct 2020 16:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604075400;
	bh=Zd4lIVf1bsz555QMx+XmVLs68UwovqEKCGJ66eBzUhc=;
	h=From:Date:Subject:To:Cc:List-ID:From;
	b=YVmDcEsTL3xYaasa4LOW2kbfkhfcPBIGAtai4GPkHdM/6lPYORjREwmzVeBThka2e
	 BEMKI1YOrzofHABeRdeSBzsmfGSpqXgk1j5rGTMST3XHzi5rXeULG2h2SKZ1EcnUKX
	 oho47OYJDjcYbDToh09V9dePKgAlIvX0RhcvNuUw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbgJ3QaA (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Fri, 30 Oct 2020 12:30:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:52924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725844AbgJ3Q37 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 30 Oct 2020 12:29:59 -0400
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B7B72151B;
        Fri, 30 Oct 2020 16:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604075399;
        bh=Zd4lIVf1bsz555QMx+XmVLs68UwovqEKCGJ66eBzUhc=;
        h=From:Date:Subject:To:Cc:From;
        b=Yo5gl6bWEa+vscqKcXDbnZ+cNEqf+Dqc77TT9cGfbxUDUVNknEn9bm4XT28bgFfSo
         EIpRMFBAOcaBFTZWaJjbaYlfjb+cy6G14GYmBB0u58zKkDTSfTj8jVjW1DYc7rU5lD
         K/K7STUnxnSj9L7e7XZLkRB3FfWgsSDC543c1L2g=
Received: by mail-qv1-f46.google.com with SMTP id w5so2993522qvn.12;
        Fri, 30 Oct 2020 09:29:59 -0700 (PDT)
X-Gm-Message-State: AOAM533Qon/54O/4e3BIkPEq7Y07PNxi1i6YHnEGUU40kbaL/Jg7oz6J
        OyyiC5pPiaoN6Pty0XwKIqV7K9xqLsuANsD0qjs=
X-Google-Smtp-Source: ABdhPJxzmAmY7xhPzaG3cP5JLj6pWRCKQ2WXEhuCWvPMgxtR74KLqkGKvXmy80cZdRvYbV7SlrEukKe8zjVwGj1uKOQ=
X-Received: by 2002:a0c:a2a6:: with SMTP id g35mr9870760qva.4.1604075398185;
 Fri, 30 Oct 2020 09:29:58 -0700 (PDT)
MIME-Version: 1.0
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Fri, 30 Oct 2020 17:29:42 +0100
X-Gmail-Original-Message-ID: <CAK8P3a37eA8s68pkHcmR_wtvPaDBouqRF7S2T+t3=YUh9HuCOg@mail.gmail.com>
Message-ID: <CAK8P3a37eA8s68pkHcmR_wtvPaDBouqRF7S2T+t3=YUh9HuCOg@mail.gmail.com>
Subject: [GIT PULL] asm-generic: bugfix for v5.10
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The following changes since commit 3650b228f83adda7e5ee532e2b90429c03f7b9ec:

  Linux 5.10-rc1 (2020-10-25 15:14:11 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git
tags/asm-generic-fixes-5.10

for you to fetch changes up to 0bcd0a2be8c9ef39d84d167ff85359a49f7be175:

  asm-generic: mark __{get,put}_user_fn as __always_inline (2020-10-27
16:13:09 +0100)

----------------------------------------------------------------
asm-generic: fixes for v5.10

There is one small bugfix, fixing a build regression for RISC-V

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

----------------------------------------------------------------
Christoph Hellwig (1):
      asm-generic: mark __{get,put}_user_fn as __always_inline

 include/asm-generic/uaccess.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)
