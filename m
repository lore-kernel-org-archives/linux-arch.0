Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.169]:63204 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750729AbXA0Ie3 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 27 Jan 2007 03:34:29 -0500
Received: by ug-out-1314.google.com with SMTP id 44so883115uga
        for <linux-arch@vger.kernel.org>; Sat, 27 Jan 2007 00:34:28 -0800 (PST)
Message-ID: <9e0cf0bf0701270034w491ff69dnb6019b4dd30f6d54@mail.gmail.com>
Date: Sat, 27 Jan 2007 10:34:27 +0200
From: "Alon Bar-Lev" <alon.barlev@gmail.com>
Subject: Re: [PATCH 10/26] Dynamic kernel command-line - ia64
In-Reply-To: <20070127002453.57b1e071.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200701230010.34323.alon.barlev@gmail.com>
	 <200701230014.06793.alon.barlev@gmail.com>
	 <20070127002453.57b1e071.akpm@osdl.org>
Sender: linux-arch-owner@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Bernhard Walle <bwalle@suse.de>
List-ID: <linux-arch.vger.kernel.org>

On 1/27/07, Andrew Morton <akpm@osdl.org> wrote:
> no no no no no no no.  Just because some whacked-out weenie went and put
> extern declarations in .c files doesn't mean that we should copy them.
>
> It doesn't even compile.

Sorry... I don't have all environments.

> Please.  Go through the entire patchset, yank all those wrong private
> declarations of boot_command_line[] and put a *single, kernel-wide*
> declaration into a single, shared header file.

I thought of this, while I was making the patch, I could not understand why
the maintainer did not simply #include <linux/init.h>

I can add this to any module which declares this by-itself but because
I cannot test all arch, I am afraid it will cause more problems.

Preparing a patch... :)

Best Regards,
Alon Bar-Lev.
