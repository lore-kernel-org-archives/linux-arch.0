From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [PATCH v2 02/13] EXPORT_SYMBOL() for asm
Date: Thu, 4 Feb 2016 18:06:43 +0000
Message-ID: <20160204180643.GU17997@ZenIV.linux.org.uk>
References: <20160203211953.GT17997@ZenIV.linux.org.uk>
 <1454534445-16759-2-git-send-email-viro@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kbuild-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1454534445-16759-2-git-send-email-viro@ZenIV.linux.org.uk>
Sender: linux-kbuild-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Wed, Feb 03, 2016 at 09:20:34PM +0000, Al Viro wrote:
> +.macro __EXPORT_SYMBOL name,val,sec
> +#ifdef CONFIG_MODULES
> +	.globl __ksymtab_\name

Should be .globl KSYM(__ksymtab_\name), to match the actual label in
> +KSYM(__ksymtab_\name):

Fix folded and pushed...
