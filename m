Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:37354
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S964827AbWEJGWP (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 10 May 2006 02:22:15 -0400
Date: Tue, 09 May 2006 23:22:15 -0700 (PDT)
Message-Id: <20060509.232215.69573210.davem@davemloft.net>
Subject: Re: [RFC/PATCH] Make powerpc64 use __thread for per-cpu variables
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060510051649.GD1794@lixom.net>
References: <17505.26159.807484.477212@cargo.ozlabs.ibm.com>
	<20060510051649.GD1794@lixom.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: olof@lixom.net
Cc: paulus@samba.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linuxppc-dev@ozlabs.org
List-ID: <linux-arch.vger.kernel.org>

From: Olof Johansson <olof@lixom.net>
Date: Wed, 10 May 2006 00:16:50 -0500

> It would be interesting to see benchmarks of how much it improves
> things. I guess it doesn't really get interesting until after the paca
> gets removed though, due to the added mfsprg's.

When I moved the per-cpu base into a fixed register on sparc64,
it definitely showed up on the micro-benchmarks because this
shrunk the .text a lot in that case.
