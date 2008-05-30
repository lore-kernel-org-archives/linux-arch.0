From: Eric Dumazet <dada1@cosmosbay.com>
Subject: Re: [patch 26/41] cpu alloc: Convert mib handling to cpu alloc
Date: Fri, 30 May 2008 08:47:43 +0200
Message-ID: <483FA30F.2050900@cosmosbay.com>
References: <20080530035620.587204923@sgi.com> <20080530040019.799353964@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp2e.orange.fr ([80.12.242.111]:22050 "EHLO smtp2e.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751307AbYE3Gru convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 30 May 2008 02:47:50 -0400
In-Reply-To: <20080530040019.799353964@sgi.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: akpm@linux-foundation.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>, Peter Zijlstra <peterz@infradead.org>, Rusty Russell <rusty@rustcorp.com.au>, Mike Travis <travis@sgi.com>

Christoph Lameter a =E9crit :
> Use the cpu alloc functions for the mib handling functions in the net
> layer. The API for snmp_mib_free() is changed to add a size parameter
> since cpu_free() requires a size parameter.
>
> Signed-off-by: Christoph Lameter <clameter@sgi.com>
> ---
>  include/net/ip.h     |    2 +-
>  include/net/snmp.h   |   32 ++++++++------------------------
>  net/dccp/proto.c     |    2 +-
>  net/ipv4/af_inet.c   |   31 +++++++++++++++++--------------
>  net/ipv6/addrconf.c  |   11 ++++++-----
>  net/ipv6/af_inet6.c  |   20 +++++++++++---------
>  net/sctp/protocol.c  |    2 +-
>  net/xfrm/xfrm_proc.c |    4 ++--
>  8 files changed, 47 insertions(+), 57 deletions(-)
>  =20
We also can avoid the use of two arrays when CONFIG_HAVE_CPU_OPS
since _CPU_INC() and __CPU_INC() are both interrupt safe.
This would reduce size of mibs by 50% and complexity (no need to sum)
