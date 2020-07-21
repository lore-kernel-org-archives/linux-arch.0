From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] x86, vmlinux.lds: Page-Align end of ..page_aligned
 sections
Date: Tue, 21 Jul 2020 11:44:07 -0700
Message-ID: <202007211143.AC36D096@keescook>
References: <20200721093448.10417-1-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727115AbgGUSoJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jul 2020 14:44:09 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AEDEC0619DA
        for <linux-arch@vger.kernel.org>; Tue, 21 Jul 2020 11:44:09 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id cv18so1755463pjb.1
        for <linux-arch@vger.kernel.org>; Tue, 21 Jul 2020 11:44:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20200721093448.10417-1-joro@8bytes.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Joerg Roedel <joro@8bytes.org>
Cc: x86@kernel.org, hpa@zytor.com, Arnd Bergmann <arnd@arndb.de>, Heiko Carstens <hca@linux.ibm.com>, Joerg Roedel <jroedel@suse.de>, Bob Haarman <inglorion@google.com>, hjl.tools@gmail.com, Arvind Sankar <nivedita@alum.mit.edu>, Dmitry Safonov <0x7f454c46@gmail.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Tue, Jul 21, 2020 at 11:34:48AM +0200, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> Align the end of the .bss..page_aligned and .data..page_aligned section
> on page-size too. Otherwise the linker might place other objects on the
> page of the last ..page_aligned object. This is inconsistent with other
> objects in those sections, which all have their own page.

What problem was actually encountered? (i.e. why is it a problem for the
other data to be in the page of the page-aligned data? shouldn't those
data have their own, separate, alignment hint?)

-- 
Kees Cook
