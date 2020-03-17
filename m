Return-Path: <SRS0=zClU=5C=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42480 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbgCQXBU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 17 Mar 2020 19:01:20 -0400
Received: by mail-pg1-f193.google.com with SMTP id h8so12539973pgs.9
        for <linux-arch@vger.kernel.org>; Tue, 17 Mar 2020 16:01:19 -0700 (PDT)
Date: Tue, 17 Mar 2020 16:01:16 -0700
From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH 7/9] arm64/build: Warn on orphan section placement
Message-ID: <202003171558.7E1D46AED6@keescook>
References: <20200228002244.15240-1-keescook@chromium.org>
 <20200228002244.15240-8-keescook@chromium.org>
 <20200317215614.GB20788@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200317215614.GB20788@willie-the-truck>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will@kernel.org>
Cc: Borislav Petkov <bp@suse.de>, "H.J. Lu" <hjl.tools@gmail.com>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, Peter Collingbourne <pcc@google.com>, James Morse <james.morse@arm.com>, Arnd Bergmann <arnd@arndb.de>, Masahiro Yamada <masahiroy@kernel.org>, x86@kernel.org, linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org, clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org
Message-ID: <20200317230116.BBoB3_J3b2SXaLYHuZSOyAcLJPyqUZmNlEhmXbOaNwI@z>

On Tue, Mar 17, 2020 at 09:56:14PM +0000, Will Deacon wrote:
> On Thu, Feb 27, 2020 at 04:22:42PM -0800, Kees Cook wrote:
> > We don't want to depend on the linker's orphan section placement
> > heuristics as these can vary between linkers, and may change between
> > versions. All sections need to be explicitly named in the linker
> > script.
> > 
> > Explicitly include debug sections when they're present. Add .eh_frame*
> > to discard as it seems that these are still generated even though
> > -fno-asynchronous-unwind-tables is being specified. Add .plt and
> > .data.rel.ro to discards as they are not actually used. Add .got.plt
> > to the image as it does appear to be mapped near .data. Finally enable
> > orphan section warnings.
> 
> Hmm, I don't understand what .got.plt is doing here. Please can you
> elaborate?

I didn't track it down, but it seems to have been present (and merged
into the kernel .data) for a while now. I can try to track this down if
you want?

-- 
Kees Cook
