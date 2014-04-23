From: Waiman Long <waiman.long@hp.com>
Subject: Re: [PATCH v9 05/19] qspinlock: Optimize for smaller NR_CPUS
Date: Wed, 23 Apr 2014 18:24:40 -0400
Message-ID: <53583DA8.4030901@hp.com>
References: <1397747051-15401-6-git-send-email-Waiman.Long@hp.com>
	<20140417155649.GR11096@twins.programming.kicks-ass.net>
	<53504BB3.4010009@hp.com>
	<20140418082716.GZ11096@twins.programming.kicks-ass.net>
	<53516672.3010701@hp.com>
	<20140418190519.GA11182@twins.programming.kicks-ass.net>
	<53519BBF.7060506@hp.com> <5357CCEF.2000606@hp.com>
	<20140423145649.GE2777@phenom.dumpdata.com>
	<5357FBDE.4040400@hp.com>
	<20140423175535.GB11152@phenom.dumpdata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20140423175535.GB11152@phenom.dumpdata.com>
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
Cc: linux-arch@vger.kernel.org, Rik van Riel <riel@redhat.com>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, Gleb Natapov <gleb@redhat.com>, kvm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Scott J Norton <scott.norton@hp.com>, x86@kernel.org, Paolo Bonzini <paolo.bonzini@gmail.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>, Chegu Vinod <chegu_vinod@hp.com>, David Vrabel <david.vrabel@citrix.com>, "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org, Thomas Gleixner <tglx@linutronix.de>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Oleg Nesterov <oleg@redhat.com>
List-Id: linux-arch.vger.kernel.org

On 04/23/2014 01:55 PM, Konrad Rzeszutek Wilk wrote:
> On Wed, Apr 23, 2014 at 01:43:58PM -0400, Waiman Long wrote:
>> On 04/23/2014 10:56 AM, Konrad Rzeszutek Wilk wrote:
>>> On Wed, Apr 23, 2014 at 10:23:43AM -0400, Waiman Long wrote:
>>>> On 04/18/2014 05:40 PM, Waiman Long wrote:
>>>>> On 04/18/2014 03:05 PM, Peter Zijlstra wrote:
>>>>>> On Fri, Apr 18, 2014 at 01:52:50PM -0400, Waiman Long wrote:
>>>>>>> I am confused by your notation.
>>>>>> Nah, I think I was confused :-) Make the 1 _Q_LOCKED_VAL though, as
>>>>>> that's the proper constant to use.
>>>>> Everyone gets confused once in a while:-) I have plenty of that myself.
>>>>>
>>>>> I will change 1 to _Q_LOCKED_VAL as suggested.
>>>>>
>>>>> -Longman
>>>> The attached patch file contains the additional changes that I had
>>>> made to qspinlock.c file so far. Please let me know if you or others
>>>> have any additional feedbacks or changes that will need to go to the
>>>> next version of the patch series.
>>>>
>>>> I am going to take vacation starting from tomorrow and will be back
>>>> on 5/5 (Mon). So I will not be able to respond to emails within this
>>>> period.
>>>>
>>>> BTW, is there any chance that this patch can be merged to 3.16?
>>> Um, it needs to have Acks from KVM and Xen maintainers who have not
>>> done so. Also Peter needs to chime in. (BTW, please CC
>>> xen-devel@lists.xenproject.org next time you post so that David and Boris
>>> can take a peek at it).
>> I will cc xen-devel@lists.xenproject.org when I sent out the next patch.
>>
>>> I would strongly recommend you put all your patches on github (free git
>>> service) so that we can test it and poke it at during your vacation
>>> (and even after).
>>>
>> I am not used to setting up a public repo in github. If I create a
>> repo there, should I put a snapshot of the whole kernel source tree
>> or just a portion of the relevant files as the base? With the later,
>> it won't be buildable.
> You just push your local branch. It should look like a normal
> Linux tree with your commits on top.

I will try that with my next version.

-Longman
