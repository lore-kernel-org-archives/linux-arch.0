Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:54094 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753134AbcBDSGo (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 4 Feb 2016 13:06:44 -0500
Date: Thu, 4 Feb 2016 18:06:43 +0000
From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [PATCH v2 02/13] EXPORT_SYMBOL() for asm
Message-ID: <20160204180643.GU17997@ZenIV.linux.org.uk>
References: <20160203211953.GT17997@ZenIV.linux.org.uk>
 <1454534445-16759-2-git-send-email-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1454534445-16759-2-git-send-email-viro@ZenIV.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20160204180643.IAq_4SsRgB-k2SVbpca0Mp_lvQ6ZtR2jqbZiJh97kkE@z>

On Wed, Feb 03, 2016 at 09:20:34PM +0000, Al Viro wrote:
> +.macro __EXPORT_SYMBOL name,val,sec
> +#ifdef CONFIG_MODULES
> +	.globl __ksymtab_\name

Should be .globl KSYM(__ksymtab_\name), to match the actual label in
> +KSYM(__ksymtab_\name):

Fix folded and pushed...
