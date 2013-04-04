From: Richard Kuo <rkuo@codeaurora.org>
Subject: Re: [PATCH 4/6] Hexagon: check to if we will overflow the signal
 stack
Date: Thu, 04 Apr 2013 11:58:58 -0500
Message-ID: <515DB152.603@codeaurora.org>
References: <1365033776-21804-1-git-send-email-rkuo@codeaurora.org> <1365033776-21804-5-git-send-email-rkuo@codeaurora.org> <CAHrUA37oTkv-x5f4zZVwqjWAqvyMdwXAokw1EDBHiGv8ozWxVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHrUA37oTkv-x5f4zZVwqjWAqvyMdwXAokw1EDBHiGv8ozWxVQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linasvepstas@gmail.com
Cc: linux-arch@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk
List-Id: linux-arch.vger.kernel.org

On 04/04/2013 11:25 AM, Linas Vepstas wrote:
> On 3 April 2013 19:02, Richard Kuo <rkuo@codeaurora.org> wrote:
>
>> +       /* check if we would overflow the alt stack */
>> +       if (on_sig_stack(sp) && !likely(on_sig_stack(sp - frame_size)))
>> +               return (void __user __force *)-1UL;
> I found the !likely construction confusing, as its doing both a
> 'unlikely' (right?) and inverting the argument. It seems clearer,
> to idiots like me, to write this as:
>
> if (on_sig_stack(sp) && unlikely(!on_sig_stack(sp - frame_size)))
>
> since where checking for overflow, and its unlikely that the overflow happened.
>
> -- Linas

I'm not sure if putting a double negative in there will make it less not 
easy to understand...


-- 

Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
