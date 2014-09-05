From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: bit fields && data tearing
Date: Thu, 4 Sep 2014 17:17:51 -0700
Message-ID: <20140905001751.GL5001@linux.vnet.ibm.com>
References: <20140712181328.GA8738@redhat.com>
 <54079B70.4050200@hurleysoftware.com>
 <1409785893.30640.118.camel@pasglop>
 <21512.10628.412205.873477@gargle.gargle.HOWL>
 <20140904090952.GW17454@tucnak.redhat.com>
 <540859EC.5000407@hurleysoftware.com>
 <20140904175044.4697aee4@alan.etchedpixels.co.uk>
 <5408C0AB.6050801@hurleysoftware.com>
 <5408E4A3.2060303@zytor.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e36.co.us.ibm.com ([32.97.110.154]:37224 "EHLO
	e36.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755579AbaIEAR6 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 4 Sep 2014 20:17:58 -0400
Received: from /spool/local
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
	Thu, 4 Sep 2014 18:17:57 -0600
Content-Disposition: inline
In-Reply-To: <5408E4A3.2060303@zytor.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Peter Hurley <peter@hurleysoftware.com>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Jakub Jelinek <jakub@redhat.com>, Mikael Pettersson <mikpelinux@gmail.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Richard Henderson <rth@twiddle.net>, Oleg Nesterov <oleg@redhat.com>, Miroslav Franc <mfranc@redhat.com>, Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org

On Thu, Sep 04, 2014 at 03:16:03PM -0700, H. Peter Anvin wrote:
> On 09/04/2014 12:42 PM, Peter Hurley wrote:
> > 
> > Or we could give up on the Alpha.
> > 
> 
> If Alpha is turning into Voyager (kept alive only as a museum piece, but
> actively causing problems) then please let's kill it.

Sorry for being slow to join this thread, but I propose the following
patch.  If we can remove support for all CPUs that to not support
direct access to bytes and shorts (which I would very much like to
see happen), I will remove the last non-guarantee.

							Thanx, Paul

------------------------------------------------------------------------

documentation: Record limitations of bitfields and small variables

This commit documents the fact that it is not safe to use bitfields
as shared variables in synchronization algorithms.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
index 87be0a8a78de..a28bfe4fd759 100644
--- a/Documentation/memory-barriers.txt
+++ b/Documentation/memory-barriers.txt
@@ -269,6 +269,26 @@ And there are a number of things that _must_ or _must_not_ be assumed:
 	STORE *(A + 4) = Y; STORE *A = X;
 	STORE {*A, *(A + 4) } = {X, Y};
 
+And there are anti-guarantees:
+
+ (*) These guarantees do not apply to bitfields, because compilers often
+     generate code to modify these using non-atomic read-modify-write
+     sequences.  Do not attempt to use bitfields to synchronize parallel
+     algorithms.
+
+ (*) Even in cases where bitfields are protected by locks, all fields
+     in a given bitfield must be protected by one lock.  If two fields
+     in a given bitfield are protected by different locks, the compiler's
+     non-atomic read-modify-write sequences can cause an update to one
+     field to corrupt the value of an adjacent field.
+
+ (*) These guarantees apply only to properly aligned and sized scalar
+     variables.  "Properly sized" currently means "int" and "long",
+     because some CPU families do not support loads and stores of
+     other sizes.  ("Some CPU families" is currently believed to
+     be only Alpha 21064.  If this is actually the case, a different
+     non-guarantee is likely to be formulated.)
+
 
 =========================
 WHAT ARE MEMORY BARRIERS?
