Return-Path: <davem@redhat.com>
Received: from mx1.redhat.com ([66.187.233.31]:65508 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265090AbUFGWB2 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 7 Jun 2004 18:01:28 -0400
Date: Mon, 7 Jun 2004 14:58:20 -0700
From: "David S. Miller" <davem@redhat.com>
Subject: Re: sys getdents64 needs compat wrapper ?
Message-Id: <20040607145820.77713eec.davem@redhat.com>
In-Reply-To: <40C4DA5E.8090700@intel.com>
References: <26879984$108508699040ad1d0eba5381.88033699@config20.schlund.de>
	<40C110C9.2060900@intel.com>
	<20040604172816.259f38e8.davem@redhat.com>
	<40C4DA5E.8090700@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Arun Sharma <arun.sharma@intel.com>
Cc: arnd@arndb.de, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Mon, 07 Jun 2004 14:13:02 -0700
Arun Sharma <arun.sharma@intel.com> wrote:

> This updated patch takes care of the __user problems that Dave pointed
> out. Regarding __put_user vs __copy_to_user, __put_user is more
> optimal on ia64 like Andrew already noted. I realize it's not optimal
> on all platforms. So I suggest that we apply the patch for now and try
> to build something that's optimal for all platforms in the future.

I agree.
