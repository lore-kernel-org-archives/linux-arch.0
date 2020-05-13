From: "Michael Kerrisk (man-pages)" <mtk.manpages-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 05/14] prctl.2: tfix listing order of prctls
Date: Wed, 13 May 2020 13:31:32 +0200
Message-ID: <6ef9a969-3e16-e21c-f047-e5a471cbc163@gmail.com>
References: <1589301419-24459-1-git-send-email-Dave.Martin@arm.com>
 <1589301419-24459-6-git-send-email-Dave.Martin@arm.com>
 <1bb991f4-176a-a74e-01fc-c73b49ed77f5@gmail.com>
 <20200513112133.GH21779@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-man-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200513112133.GH21779-5wv7dgnIgG8@public.gmane.org>
Content-Language: en-US
Sender: linux-man-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dave Martin <Dave.Martin-5wv7dgnIgG8@public.gmane.org>
Cc: mtk.manpages-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-man-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-arch.vger.kernel.org

Hi Dave,

On 5/13/20 1:21 PM, Dave Martin wrote:
> On Wed, May 13, 2020 at 12:10:53PM +0200, Michael Kerrisk (man-pages) wrote:
>> Hi Dave,
>>
>> On 5/12/20 6:36 PM, Dave Martin wrote:
>>> The prctl list has historically been sorted by prctl name (ignoring
>>> any SET_ or GET_ prefix) to make individual prctls easier to find.
>>> Some noise seems to have crept in since.
>>>
>>> Sort the list back into order.  Similarly, reorder the list of
>>> prctls specified to return non-zero values on success.
>>
>> This is a good patch. But see my comments on patch 04.
>> I'd prefer a patch like this at the end of a series, 
>> rather than in the middle of it.
> 
> Ack.
> 
> Ideally we could check the order with a script, but that seemed a step
> too far.

Quite.

> What's the view on having parts of the man pages generated, rather then
> being distributed ready-built?

I'm not keen (until someone shows me compelling benefits). Splitting
things up would make pages harder to edit, and IMO increase
the chance for inconsistencies in pages.

> If we split prctl.2 up with a fragment per prctl, we could paste the
> fragments together in the right order with a script.
> 
>>
>>> Content movement only.  No semantic change.
>>
>> And explicitly noting that detail is very helpful to me.
> 
> Unless of course I'm lying ;)  (I'm not, but I won't be offended if you
> check.)

Actually, with your first two patches, you impressed right out of
the gate, so my "I'm gonna blindly trust this guy" needle already
switched up pretty high :-).

Cheers,

Michael

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
