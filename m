From: Jens Axboe <axboe@kernel.dk>
Subject: Re: linux-next: manual merge of the pidfd tree with the y2038 tree
Date: Mon, 21 Jan 2019 15:44:17 -0700
Message-ID: <da262bd9-1de0-eabb-ee44-e0ee152d15bb@kernel.dk>
References: <20190121143951.68956db3@canb.auug.org.au>
 <CAK8P3a0Yth+f8AANE6g8c_zE0Zt1CvCdzMDFK=pr8eNqmrBV0Q@mail.gmail.com>
 <20190121191306.ifga5aw5atu2vvb7@brauner.io>
 <CAK8P3a2CkXJ=giXQgxEcQAeH1Wt8jKc_P+YTOLJpUPVKYU8m9g@mail.gmail.com>
 <20190121202328.rgrv54lybilsvitu@brauner.io>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190121202328.rgrv54lybilsvitu@brauner.io>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Christian Brauner <christian@brauner.io>, Arnd Bergmann <arnd@arndb.de>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Linux Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On 1/21/19 1:23 PM, Christian Brauner wrote:
> On Mon, Jan 21, 2019 at 09:15:27PM +0100, Arnd Bergmann wrote:
>> On Mon, Jan 21, 2019 at 8:13 PM Christian Brauner <christian@brauner.io> wrote:
>>> On Mon, Jan 21, 2019 at 06:16:22PM +0100, Arnd Bergmann wrote:
>>>> On Mon, Jan 21, 2019 at 4:40 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>>>
>>> I plan on sending the pidfd branch with the new pidfd_send_signal()
>>> syscall for the 5.1 window. Should we somehow coordinate so that our
>>> branches don't conflict? Any suggestions?
>>
>> A conflict can't be avoided, but if you pick system call number 427
>> for pidfd_send_signal, and Jens picks numbers 424 through 426 for
> 
> That sounds good to me. Since it's only one syscall for the pidfd branch
> is there anything that speaks against me using 424? Given that the other
> patchset has 4 new syscalls. :)
> Jens, any objections?

I'm fine with either one, I'll have to renumber in any case. But it's 3
new syscalls (424, 425, 426), not 4.

Arnd, what's the best way to make this switch now, in my tree? Would be
great if I didn't have to change it again once I make the change.

-- 
Jens Axboe
