Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S268762AbUHTVlE@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:57802 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268759AbUHTVlD (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 20 Aug 2004 17:41:03 -0400
Date: Fri, 20 Aug 2004 14:40:52 -0700
From: "David S. Miller" <davem@redhat.com>
Subject: Re: copy_mount_options()
Message-Id: <20040820144052.14413a4f.davem@redhat.com>
In-Reply-To: <20040820143111.3fd0070e.akpm@osdl.org>
References: <20040820130110.07f7c23c.davem@redhat.com>
	<20040820131053.3d5e0f9b.akpm@osdl.org>
	<20040820141137.646c349f.davem@redhat.com>
	<20040820143111.3fd0070e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@osdl.org>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Fri, 20 Aug 2004 14:31:11 -0700
Andrew Morton <akpm@osdl.org> wrote:

> Something like this?

Looks pretty good.  Although I would do a verify_area() above
the loop and then use __get_user().

I know this doesn't need to be fast, but it doesn't need to
be that slow either :-)))
