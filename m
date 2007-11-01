Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:42874
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1751826AbXKAAYW (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 31 Oct 2007 20:24:22 -0400
Date: Wed, 31 Oct 2007 17:24:21 -0700 (PDT)
Message-Id: <20071031.172421.228723187.davem@davemloft.net>
Subject: Re: [patch 0/7] [RFC] SLUB: Improve allocpercpu to reduce per cpu
 access overhead
From: David Miller <davem@davemloft.net>
In-Reply-To: <20071101000211.970501947@sgi.com>
References: <20071101000211.970501947@sgi.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: clameter@sgi.com
Cc: akpm@linux-foundation.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, mathieu.desnoyers@polymtl.ca, penberg@cs.helsinki.fi
List-ID: <linux-arch.vger.kernel.org>


Are these patches against -mm or mainline?

I get a lot of rejects starting with patch 6 against
mainline and I really wanted to test them out on sparc64.

Thanks.
