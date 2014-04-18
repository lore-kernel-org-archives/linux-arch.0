From: Waiman Long <waiman.long@hp.com>
Subject: Re: [PATCH v9 03/19] qspinlock: Add pending bit
Date: Fri, 18 Apr 2014 14:12:52 -0400
Message-ID: <53516B24.3060108@hp.com>
References: <1397747051-15401-1-git-send-email-Waiman.Long@hp.com>
	<1397747051-15401-4-git-send-email-Waiman.Long@hp.com>
	<20140418074255.GA13517@gmail.com> <53515181.8090303@hp.com>
	<20140418163543.GA6208@phenom.dumpdata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20140418163543.GA6208@phenom.dumpdata.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: linux-arch@vger.kernel.org, Rik van Riel <riel@redhat.com>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, Gleb Natapov <gleb@redhat.com>, kvm@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Scott J Norton <scott.norton@hp.com>, x86@kernel.org, Paolo Bonzini <paolo.bonzini@gmail.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>, Chegu Vinod <chegu_vinod@hp.com>, David Vrabel <david.vrabel@citrix.com>, "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org, Thomas Gleixner <tglx@linutronix.de>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>
List-Id: linux-arch.vger.kernel.org

On 04/18/2014 12:35 PM, Konrad Rzeszutek Wilk wrote:
> On Fri, Apr 18, 2014 at 12:23:29PM -0400, Waiman Long wrote:
>> On 04/18/2014 03:42 AM, Ingo Molnar wrote:
>>> * Waiman Long<Waiman.Long@hp.com>   wrote:
>>>
>>>> Because the qspinlock needs to touch a second cacheline; add a pending
>>>> bit and allow a single in-word spinner before we punt to the second
>>>> cacheline.
>>>>
>>>> Signed-off-by: Peter Zijlstra<peterz@infradead.org>
>>>> Signed-off-by: Waiman Long<Waiman.Long@hp.com>
>>> This patch should have a "From: Peter" in it as well, right?
>>>
>>> Thanks,
>>>
>>> 	Ingo
>> Do you mean a "From:" line in the mail header? It will be a bit hard
>> to have different "From:" header in the same patch series. I can
>> certainly do that if there is an easy way to do it.
> It is pretty easy.
>
> Just do 'git commit --amend --author "The Right Author"' and when
> you send the patches (git send-email) it will include that.

Thank for the tip. I will do that in the next version.

-Longman
