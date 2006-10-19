Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:14542 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1423036AbWJSQ6l
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 19 Oct 2006 12:58:41 -0400
Date: Thu, 19 Oct 2006 17:58:34 +0100
From: Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [RFC] typechecking for get_unaligned/put_unaligned
Message-ID: <20061019165834.GU29920@ftp.linux.org.uk>
References: <20061017005025.GF29920@ftp.linux.org.uk> <20061018054242.GA21266@redhat.com> <20061018060500.GI29920@ftp.linux.org.uk> <200610191852.50967.vda.linux@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200610191852.50967.vda.linux@googlemail.com>
Sender: linux-arch-owner@vger.kernel.org
To: Denis Vlasenko <vda.linux@googlemail.com>
Cc: Dave Jones <davej@redhat.com>, Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Thu, Oct 19, 2006 at 06:52:50PM +0200, Denis Vlasenko wrote:
> Well, logically for any given .config a set of all kernel header files
> define a set of typedefs, structs, functions and so on.
> If only we can read and parse them just once, and then reuse
> already parsed information when we compile each .c file -
> that will give you the biggest time savings.
> 
> gcc has some facility for that ("precompiled headers")
> http://gcc.gnu.org/onlinedocs/gcc/Precompiled-Headers.html
> 
> I don't know how hard it will be to adapt build system to using that
> and there is a danger that using this thing will increase
> recompile times when you change just a few CONFIG_XXXs.

Or when you touch a single header.  A brialliant idea, that.
