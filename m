From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [PATCH v2 01/13] [kbuild] handle exports in lib-y objects
 reliably
Date: Fri, 5 Feb 2016 00:18:07 +0000
Message-ID: <20160205001807.GV17997@ZenIV.linux.org.uk>
References: <20160203211953.GT17997@ZenIV.linux.org.uk>
 <1454534445-16759-1-git-send-email-viro@ZenIV.linux.org.uk>
 <56B3D1B7.4080305@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:57305 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752562AbcBEASJ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 4 Feb 2016 19:18:09 -0500
Content-Disposition: inline
In-Reply-To: <56B3D1B7.4080305@suse.cz>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michal Marek <mmarek@suse.cz>
Cc: linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Feb 04, 2016 at 11:33:27PM +0100, Michal Marek wrote:
> Acked-by: Michal Marek <mmarek@suse.cz>
> 
> Sorry for the delay.
> > +dummy-object = $(obj)/__lib_exports.o
> > +ksyms-lds = $(obj)/lib-ksyms.lds
> 
> Just a really minor nitpick (no need to resend just because of it): We
> typically use dotfiles for temporary stuff, e.g.
> 
> dummy-object = $(obj)/.lib_exports.o
> ksyms-lds = $(dot-target).lds

Folded and pushed...
