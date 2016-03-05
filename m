From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v2] x86: PAT: Documentation: rewrite "MTRR effects on PAT
 / non-PAT systems"
Date: Sat, 5 Mar 2016 12:52:55 +0100
Message-ID: <20160305115255.GA11846@gmail.com>
References: <20160304210900.GT3577@linux.vnet.ibm.com>
 <1457131501-14855-1-git-send-email-mcgrof@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1457131501-14855-1-git-send-email-mcgrof@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: paulmck@linux.vnet.ibm.com, bp@alien8.de, tglx@linutronix.de, hpa@zytor.com, toshi.kani@hp.com, airlied@redhat.com, benh@kernel.crashing.org, mst@redhat.com, vinod.koul@intel.com, jgross@suse.com, daniel.vetter@ffwll.ch, luto@amacapital.net, davem@davemloft.net, ben@decadent.org.uk, benjamin.poirier@gmail.com, linux-fbdev@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org, linux-doc@vger.kernel.org, corbet@lwn.net
List-Id: linux-arch.vger.kernel.org


* Luis R. Rodriguez <mcgrof@kernel.org> wrote:

> The current documentation refers to using set_memory_wc() as a
> possible hole strategy when you have overlapping ioremap() regions,

The whole explanation should talk about virtual aliases over the same physical 
address, not some 'overlapping regions'.

I see where this talk about 'overlap' comes: the memtype rbtree in 
arch/x86/mm/pat_rbtree.c indeed has memtype ranges that may overlap on the 
physical side. But it is highly confusing to call this 'overlapping' on the driver 
API documentation level without making it really clear what it's about.

Thanks,

	Ingo
