Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp5.pp.htv.fi ([213.243.153.39]:40506 "EHLO smtp5.pp.htv.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755906AbYATW3O (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 20 Jan 2008 17:29:14 -0500
Date: Mon, 21 Jan 2008 00:27:54 +0200
From: Adrian Bunk <bunk@kernel.org>
Subject: Re: kbuild: improved Section mismatch detection
Message-ID: <20080120222754.GK8669@does.not.exist>
References: <20080120200527.GA23852@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20080120200527.GA23852@uranus.ravnborg.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux-kbuild <linux-kbuild@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux arch <linux-arch@vger.kernel.org>

On Sun, Jan 20, 2008 at 09:05:27PM +0100, Sam Ravnborg wrote:
>...
> Adrian reminded us that KCFLAGS=-fno-inline told
> another story with more than 100 Section mismatch
> warnings on 64 bit x86 with an allyesconfig build.
>...

Not -fno-inline but -fno-inline-functions-called-once
(completely different option).

> 	Sam

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

