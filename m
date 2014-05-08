From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v10 07/19] qspinlock: Use a simple write to grab the
	lock, if applicable
Date: Thu, 8 May 2014 21:00:04 +0200
Message-ID: <20140508190004.GO2844@laptop.programming.kicks-ass.net>
References: <1399474907-22206-1-git-send-email-Waiman.Long@hp.com>
	<1399474907-22206-8-git-send-email-Waiman.Long@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1399474907-22206-8-git-send-email-Waiman.Long@hp.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Waiman Long <Waiman.Long@hp.com>
Cc: linux-arch@vger.kernel.org, Rik van Riel <riel@redhat.com>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, Oleg Nesterov <oleg@redhat.com>, Gleb Natapov <gleb@redhat.com>, kvm@vger.kernel.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Scott J Norton <scott.norton@hp.com>, x86@kernel.org, Paolo Bonzini <paolo.bonzini@gmail.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>, Chegu Vinod <chegu_vinod@hp.com>, David Vrabel <david.vrabel@citrix.com>, "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org, Thomas Gleixner <tglx@linutronix.de>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>
List-Id: linux-arch.vger.kernel.org

On Wed, May 07, 2014 at 11:01:35AM -0400, Waiman Long wrote:
> @@ -94,23 +94,29 @@ static inline struct mcs_spinlock *decode_tail(u32 tail)
>   * can allow better optimization of the lock acquisition for the pending
>   * bit holder.
>   */
> -#if _Q_PENDING_BITS == 8
> -
>  struct __qspinlock {
>  	union {
>  		atomic_t val;
> -		struct {
>  #ifdef __LITTLE_ENDIAN
> +		u8	 locked;
> +		struct {
>  			u16	locked_pending;
>  			u16	tail;
> +		};
>  #else
> +		struct {
>  			u16	tail;
>  			u16	locked_pending;
> -#endif
>  		};
> +		struct {
> +			u8	reserved[3];
> +			u8	locked;
> +		};
> +#endif
>  	};
>  };
>  
> +#if _Q_PENDING_BITS == 8

That doesn't make sense, that struct __qspinlock only makes sense when
_Q_PENDING_BITS == 8.
