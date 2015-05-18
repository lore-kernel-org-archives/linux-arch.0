From: David Hildenbrand <dahi@linux.vnet.ibm.com>
Subject: Re: [PATCH v1 00/15] decouple pagefault_disable() from
 preempt_disable()
Date: Mon, 18 May 2015 14:46:24 +0200
Message-ID: <20150518144624.3fb3fa46@thinkpad-w530>
References: <1431359540-32227-1-git-send-email-dahi@linux.vnet.ibm.com>
	<alpine.DEB.2.11.1505151620390.4225@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <alpine.DEB.2.11.1505151620390.4225@nanos>
Sender: owner-linux-mm@kvack.org
To: Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com, akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, yang.shi@windriver.com, bigeasy@linutronix.de, benh@kernel.crashing.org, paulus@samba.org, heiko.carstens@de.ibm.com, schwidefsky@de.ibm.com, borntraeger@de.ibm.com, mst@redhat.com, David.Laight@ACULAB.COM, hughd@google.com, hocko@suse.cz, ralf@linux-mips.org, herbert@gondor.apana.org.au, linux@arm.linux.org.uk, airlied@linux.ie, daniel.vetter@intel.com, linux-mm@kvack.org, linux-arch@vger.kernel.org, peterz@infradead.org
List-Id: linux-arch.vger.kernel.org

> Thanks for picking that up (again)!
> 
> We've pulled the lot into RT and unsurprisingly it works like a charm :)
> 
> Works on !RT as well. 
> 
> Reviewed-and-tested-by: Thomas Gleixner <tglx@linutronix.de>
> 

Thanks a lot Thomas!

@Ingo, @Andrew, nothing changed during the review of this version and Thomas
gave it a review + test.

Any of you willing to pick this up to give it a shot? Or should I resend it with
Thomas' tags added.

Thanks!

David

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
