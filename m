Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-in-03.arcor-online.net ([151.189.21.43]:38818 "EHLO
	mail-in-03.arcor-online.net") by vger.kernel.org with ESMTP
	id S1750827AbWEKXmo (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 11 May 2006 19:42:44 -0400
In-Reply-To: <17506.37259.755099.974824@cargo.ozlabs.ibm.com>
References: <17505.26159.807484.477212@cargo.ozlabs.ibm.com> <20060510154702.GA28938@twiddle.net> <20060510.124003.04457042.davem@davemloft.net> <17506.21908.857189.645889@cargo.ozlabs.ibm.com> <20060511010438.GE24458@bubble.grove.modra.org> <17506.37259.755099.974824@cargo.ozlabs.ibm.com>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <8A6EEC0A-70EE-4B77-9185-A194632B16A5@kernel.crashing.org>
Content-Transfer-Encoding: 7bit
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC/PATCH] Make powerpc64 use __thread for per-cpu variables
Date: Fri, 12 May 2006 01:42:39 +0200
Sender: linux-arch-owner@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
Cc: Alan Modra <amodra@bigpond.net.au>, "David S. Miller" <davem@davemloft.net>, linux-arch@vger.kernel.org, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, rth@twiddle.net
List-ID: <linux-arch.vger.kernel.org>

>> gcc shouldn't think there is any reason to cache the address.
>
> Can I rely on that being true in the future?

As long as the compiler stays smart enough, and doesn't do
stupid things :-)

(i.e., no.  Sigh).


Segher

