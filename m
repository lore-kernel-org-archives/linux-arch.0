From: KOSAKI Motohiro <kosaki.motohiro@gmail.com>
Subject: Re: [patch 21/29] score: Use generic init_task
Date: Tue, 1 May 2012 09:46:17 -0400
Message-ID: <CAHGf_=p4+fBgZZh4v7-rou1h3kx12b6=uwtjdnh0PvA+R5WVaA@mail.gmail.com>
References: <20120430194725.763322463@linutronix.de> <20120430194846.862605948@linutronix.de>
 <4F9EF43C.3090608@gmail.com> <alpine.LFD.2.02.1204302238120.6271@ionos> <alpine.LFD.2.02.1204302248310.6271@ionos>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LFD.2.02.1204302248310.6271@ionos>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Chen Liqin <liqin.chen@sunplusct.com>
List-Id: linux-arch.vger.kernel.org

On Mon, Apr 30, 2012 at 4:49 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Mon, 30 Apr 2012, Thomas Gleixner wrote:
>> On Mon, 30 Apr 2012, KOSAKI Motohiro wrote:
>> > Almost patches delete arch specific init-task. But this patch doesn't.
>> > Is this really intentional?
>>
>> Not really. I missed it :( Will fix.
>
> Here is the updated one.
>
> Thanks,

Seems good. (but obviously I'm not score expert, don't believe me).

Thanks.
