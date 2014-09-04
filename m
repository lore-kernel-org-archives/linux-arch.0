From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: bit fields && data tearing
Date: Thu, 04 Sep 2014 15:14:48 -0700
Message-ID: <5408E458.3@zytor.com>
References: <20140712181328.GA8738@redhat.com>	 <54079B70.4050200@hurleysoftware.com> <1409785893.30640.118.camel@pasglop>	 <063D6719AE5E284EB5DD2968C1650D6D17487172@AcuExch.aculab.com> <1409824374.4246.62.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ia64-owner@vger.kernel.org>
In-Reply-To: <1409824374.4246.62.camel@pasglop>
Sender: linux-ia64-owner@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Laight <David.Laight@ACULAB.COM>
Cc: Peter Hurley <peter@hurleysoftware.com>, Jakub Jelinek <jakub@redhat.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Tony Luck <tony.luck@intel.com>, "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>, Oleg Nesterov <oleg@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Paul Mackerras <paulus@samba.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Miroslav Franc <mfranc@redhat.com>, Richard Henderson <rth@twiddle.net>
List-Id: linux-arch.vger.kernel.org

On 09/04/2014 02:52 AM, Benjamin Herrenschmidt wrote:
> 
> Yeah correct, alpha and bytes right ? Is there any other ? That's why I
> suggested int.
> 

Even for Alpha it is only the 21064 AFAIK.

	-hpa


