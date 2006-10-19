Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:36742 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1946228AbWJSQyi (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 19 Oct 2006 12:54:38 -0400
Received: by ug-out-1314.google.com with SMTP id o38so514952ugd
        for <linux-arch@vger.kernel.org>; Thu, 19 Oct 2006 09:54:35 -0700 (PDT)
From: Denis Vlasenko <vda.linux@googlemail.com>
Subject: Re: [RFC] typechecking for get_unaligned/put_unaligned
Date: Thu, 19 Oct 2006 18:52:50 +0200
References: <20061017005025.GF29920@ftp.linux.org.uk> <20061018054242.GA21266@redhat.com> <20061018060500.GI29920@ftp.linux.org.uk>
In-Reply-To: <20061018060500.GI29920@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610191852.50967.vda.linux@googlemail.com>
Sender: linux-arch-owner@vger.kernel.org
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Dave Jones <davej@redhat.com>, Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Wednesday 18 October 2006 08:05, Al Viro wrote:
> That's the point, actually - apparently we have several high-impact includes
> that are easy to sever and that are really worth being severed.  The part
> that was not aproiri obvious:
> 	* there are clusters of headers around certain dependency
> counts.
> 	* such clusters tend to have leaders - header that pulls the
> rest and even though other headers are apparently independently included,
> all such includes end up being hidden by includes of the leader.
> 	* gaps between the clusters are pretty large.
> 	* dependency graph *on* *clusters* is worth being studied; includes
> of cluster leader from cluster around slightly smaller dependency count
> are prime targets for severing.
> 
> That is the new part here.  Not just "dependency graph is a mess and ought
> to be cleaned up" - _that_ is neither new nor particulary useful...

Well, logically for any given .config a set of all kernel header files
define a set of typedefs, structs, functions and so on.
If only we can read and parse them just once, and then reuse
already parsed information when we compile each .c file -
that will give you the biggest time savings.

gcc has some facility for that ("precompiled headers")
http://gcc.gnu.org/onlinedocs/gcc/Precompiled-Headers.html

I don't know how hard it will be to adapt build system to using that
and there is a danger that using this thing will increase
recompile times when you change just a few CONFIG_XXXs.
--
vda
