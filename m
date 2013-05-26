From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: possible problem with generic asm/types.h
Date: Sun, 26 May 2013 12:32:22 +0200
Message-ID: <201305261232.22733.arnd@arndb.de>
References: <1369494858.25297.58.camel@t520.redhat.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:62465 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752263Ab3EZKcb (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 26 May 2013 06:32:31 -0400
In-Reply-To: <1369494858.25297.58.camel@t520.redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Salter <msalter@redhat.com>
Cc: linux-arch@vger.kernel.org, catalin.marinas@arm.com

On Saturday 25 May 2013, Mark Salter wrote:
> 
> While building some stuff for aarch64, I ran into a conflict between
> the kernel's definition of __s64 and glibc's definition of int64_t.
> The package I was building (fuse) does this:
> 
>   #include <stdint.h>
>   #define __s64 int64_t

It's an old bug in fuse. The header that ships with the kernel
should work fine, just update your user space package.

	Arnd
