Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from one.firstfloor.org ([213.235.205.2]:37510 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751219AbXGJLsq (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 10 Jul 2007 07:48:46 -0400
Date: Tue, 10 Jul 2007 13:48:43 +0200
From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [x86 setup 09/33] Make definitions for struct e820entry and struct e820map consistent
Message-ID: <20070710114843.GA5869@one.firstfloor.org>
References: <2034f71d414def30de582fb59573295cadbdabb4.1184032748.git.hpa@zytor.com> <361d0a8b7b7ea9d41d0c25664b3e2b30fd99e329.1184032749.git.hpa@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <361d0a8b7b7ea9d41d0c25664b3e2b30fd99e329.1184032749.git.hpa@zytor.com>
Sender: linux-arch-owner@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, andi@firstfloor.org, akpm@linux-foundation.org
List-ID: <linux-arch.vger.kernel.org>

> diff --git a/include/asm-x86_64/e820.h b/include/asm-x86_64/e820.h
> index 6216fa3..15eb8e2 100644
> --- a/include/asm-x86_64/e820.h
> +++ b/include/asm-x86_64/e820.h
> @@ -11,7 +11,9 @@
>  #ifndef __E820_HEADER
>  #define __E820_HEADER
>  
> -#include <linux/mmzone.h>
> +#ifndef _SETUP
> +# include <linux/mmzone.h>
> +#endif

If the ifdef is valid then the include can be completely removed.

-Andi
