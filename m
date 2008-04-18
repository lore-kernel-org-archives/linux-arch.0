From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/3] [POWERPC] Fix kernel stack allocation alignment
Date: Fri, 18 Apr 2008 18:18:18 +1000
Message-ID: <1208506698.6958.400.camel@pasglop>
References: <20080418065727.5FE1CDE247@ozlabs.org>
	<20080418000618.0c46c78f.akpm@linux-foundation.org>
Reply-To: benh@kernel.crashing.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org>
In-Reply-To: <20080418000618.0c46c78f.akpm@linux-foundation.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org


> so...  the "0" defeats all of SLAB_DEBUG_FREE, SLAB_RED_ZONE, SLAB_POISON
> and SLAB_STORE_USER, if the comment in slab.h is to be believed.
> 
> Was that overkill?

Well, I copied over from something else, looks like there's a -lot- of 0
users here... 

Shouldn't there be some kind of SLAB_DEFAULT that contain those things ?

Ben.
