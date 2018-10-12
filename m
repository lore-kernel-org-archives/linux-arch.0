From: Helge Deller <deller@gmx.de>
Subject: Re: [PATCH v4 5/6] parisc: wire up rseq system call
Date: Fri, 12 Oct 2018 22:23:29 +0200
Message-ID: <71ea9dc5-7502-40af-2022-b2196dd2d690@gmx.de>
References: <1539337442-3676-1-git-send-email-firoz.khan@linaro.org>
 <1539337442-3676-6-git-send-email-firoz.khan@linaro.org>
 <CAK8P3a1gsuM7mBGm9hx-BTs=HAG3cSjB6M7N-kpMmPy3kixeCQ@mail.gmail.com>
 <CALxhOnhj7qUj57tLX12KmbcE5G-zDK2Qf2fTUbQ=jpmiUcr52w@mail.gmail.com>
 <CAK8P3a3BjuLQh0hTPFTDTkipXXQ+j8ADqbWmNpimkMDzoORkRA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK8P3a3BjuLQh0hTPFTDTkipXXQ+j8ADqbWmNpimkMDzoORkRA@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Firoz Khan <firoz.khan@linaro.org>
Cc: Parisc List <linux-parisc@vger.kernel.org>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Thomas Gleixner <tglx@linutronix.de>, gregkh <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Kate Stewart <kstewart@linuxfoundation.org>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Deepa Dinamani <deepa.kernel@gmail.com>, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
List-Id: linux-arch.vger.kernel.org

On 12.10.2018 13:52, Arnd Bergmann wrote:
> On Fri, Oct 12, 2018 at 12:16 PM Firoz Khan <firoz.khan@linaro.org> wrote:
>>
>> Hi Arnd,
>>
>> On Fri, 12 Oct 2018 at 15:26, Arnd Bergmann <arnd@arndb.de> wrote:
>>>
>>> On Fri, Oct 12, 2018 at 11:45 AM Firoz Khan <firoz.khan@linaro.org> wrote:
>>>>
>>>> Wire up rseq system call requires an architecture specific
>>>> implementation as it not present now.
>>>>
>>>> Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
>>>
>>> Didn't we conclude that this should be skipped?
>>
>> Helge told "I prefer to keep the warning for rseq for now.
>> It reminds me that we still may want the rseq syscall.
>> If the warning is a problem, you may simply add the __IGNORE_rseq define."
>>
>> I chose this option; I feel it looks clean
>> "# rseq requires an architecture specific implementation" in syscall.tbl
>> hopefully remind him to add rseq syscall implementation in this architecture.
> 
> But he said he wants the warning instead.

Correct.
Firoz, please simply drop this patch completely.
That way one will see generated warnings about the missing rseq (which is what
we want).

Thanks,
Helge
