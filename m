Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from detroit.securenet-server.net ([209.51.153.26]:8388 "EHLO
	detroit.securenet-server.net") by vger.kernel.org with ESMTP
	id S1751413AbWCGSq3 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 7 Mar 2006 13:46:29 -0500
From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [PATCH] Document Linux's memory barriers
Date: Tue, 7 Mar 2006 10:46:11 -0800
References: <200603071134.52962.ak@suse.de> <31492.1141753245@warthog.cambridge.redhat.com> <7621.1141756240@warthog.cambridge.redhat.com>
In-Reply-To: <7621.1141756240@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603071046.11980.jbarnes@virtuousgeek.org>
Sender: linux-arch-owner@vger.kernel.org
To: David Howells <dhowells@redhat.com>
Cc: Andi Kleen <ak@suse.de>, torvalds@osdl.org, akpm@osdl.org, mingo@redhat.com, linux-arch@vger.kernel.org, linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Tuesday, March 7, 2006 10:30 am, David Howells wrote:
> True, I suppose. I should make it clear that these accessor functions
> imply memory barriers, if indeed they do, and that you should use them
> rather than accessing I/O registers directly (at least, outside the
> arch you should).

But they don't, that's why we have mmiowb().  There are lots of cases to 
handle:
  1) memory vs. memory
  2) memory vs. I/O
  3) I/O vs. I/O
(reads and writes for every case).

AFAIK, we have (1) fairly well handled with a plethora of barrier ops.  
(2) is a bit fuzzy with the current operations I think, and for (3) all 
we have is mmiowb() afaik.  Maybe one of the ppc64 guys can elaborate on 
the barriers their hw needs for the above cases (I think they're the 
pathological case, so covering them should be good enough everybody).

Btw, thanks for putting together this documentation, it's desperately 
needed.

Jesse
