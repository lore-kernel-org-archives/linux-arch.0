Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S268750AbUHTVLs@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:59324 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268749AbUHTVLs (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 20 Aug 2004 17:11:48 -0400
Date: Fri, 20 Aug 2004 14:11:37 -0700
From: "David S. Miller" <davem@redhat.com>
Subject: Re: copy_mount_options()
Message-Id: <20040820141137.646c349f.davem@redhat.com>
In-Reply-To: <20040820131053.3d5e0f9b.akpm@osdl.org>
References: <20040820130110.07f7c23c.davem@redhat.com>
	<20040820131053.3d5e0f9b.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@osdl.org>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Fri, 20 Aug 2004 13:10:53 -0700
Andrew Morton <akpm@osdl.org> wrote:

> For some reason, copy_mount_options() is a continual pain in the ass.  It
> just comes up again and again.
> 
> For this problem I'd suggest we just rip the copy_from_user() out of there
> and rewrite the function to use byte-at-a-time get_user()s.

I totally agree.
