From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 14/18] ipv4: prevent bounds-check bypass via speculative execution
Date: Sat, 6 Jan 2018 08:29:22 -0800
Message-ID: <CAPcyv4jsbwaBy29-L3rV__9AiMuZk7aO-0CguH6RNLYKgWWoYw@mail.gmail.com>
References: <151520099201.32271.4677179499894422956.stgit@dwillia2-desk3.amr.corp.intel.com>
 <151520107001.32271.12149241186695668220.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20180106090154.GE4380@kroah.com> <20180106122347.7a5c8ee6@alans-desktop> <20180106151424.GA17924@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180106151424.GA17924@kroah.com>
Sender: netdev-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, Netdev <netdev@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Elena Reshetova <elena.reshetova@intel.com>, Alan Cox <alan@linux.intel.com>
List-Id: linux-arch.vger.kernel.org

On Sat, Jan 6, 2018 at 7:14 AM, Greg KH <gregkh@linuxfoundation.org> wrote:
> On Sat, Jan 06, 2018 at 12:23:47PM +0000, Alan Cox wrote:
>> On Sat, 6 Jan 2018 10:01:54 +0100
>> Greg KH <gregkh@linuxfoundation.org> wrote:
>>
>> > On Fri, Jan 05, 2018 at 05:11:10PM -0800, Dan Williams wrote:
>> > > Static analysis reports that 'offset' may be a user controlled value
>> >
>> > Can I see the rule that determined that?  It does not feel like that is
>> > correct, given the 3+ levels deep that this function gets this value
>> > from...
>>
>> On a current x86 you can execute something upwards of 150 instructions in
>> a speculation window.
>
> Yeah, I agree, it's deep :(
>
> But for this patch, I thought the prior review determined that it was
> not a problem.  Was that somehow proven incorrect?

I kept it in the series to get a re-review with the wider netdev
because I missed the discussion leading up to that 'drop the patch'
decision. Sorry, I should have noted that in the changelog or cover
letter.
