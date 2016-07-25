From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 02/14] x86: migrate exception table users off module.h
 and onto extable.h
Date: Mon, 25 Jul 2016 08:35:58 +0200
Message-ID: <20160725063558.GA12474@gmail.com>
References: <20160725034247.109173-1-paul.gortmaker@windriver.com>
 <20160725034247.109173-3-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33319 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750844AbcGYGgE (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 25 Jul 2016 02:36:04 -0400
Content-Disposition: inline
In-Reply-To: <20160725034247.109173-3-paul.gortmaker@windriver.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org


* Paul Gortmaker <paul.gortmaker@windriver.com> wrote:

> These files were only including module.h for exception table
> related functions.  We've now separated that content out into its
> own file "extable.h" so now move over to that and avoid all the
> extra header content in module.h that we don't really need to compile
> these files.
> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: x86@kernel.org
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
