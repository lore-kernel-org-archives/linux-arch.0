From: Greg Ungerer <gerg@snapgear.com>
Subject: Re: [PATCH v3 00/11] m68k: use asm-generic headers when possible
Date: Wed, 14 Nov 2012 20:29:33 +1000
Message-ID: <50A3728D.9010209@snapgear.com>
References: <1351578277-31882-1-git-send-email-gerg@snapgear.com> <CAMuHMdXbwBLhryrcJ5Ln3uvBJL=_ZCYBErXyZzGznBirobU1kQ@mail.gmail.com> <50A078CC.7080406@snapgear.com> <CAMuHMdVWaxjGYFXHwK6-CPUA3YFZ2x7k11FpPhMyudHt0xVa4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-m68k-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdVWaxjGYFXHwK6-CPUA3YFZ2x7k11FpPhMyudHt0xVa4g@mail.gmail.com>
Sender: linux-m68k-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-m68k@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Hi Geert,

On 11/14/2012 05:56 PM, Geert Uytterhoeven wrote:
> On Mon, Nov 12, 2012 at 5:19 AM, Greg Ungerer <gerg@snapgear.com> wrote:
>> On 11/11/12 20:30, Geert Uytterhoeven wrote:
>>> On Tue, Oct 30, 2012 at 7:24 AM,  <gerg@snapgear.com> wrote:
>>>> Quite a few of the m68k asm headers are identical to the asm-generic
>>>> versions. So switch to using them where ever we can.
>>>>
>>>> v2 is rebased on top of 3.7-rc3.
>>>> v3 keep those in uapi/asm in uapi/asm (not moved to asm-generic)
>>>>
>>>> All defconfigs build. Run tested on ColdFire (with and without MMU) and
>>>> on
>>>> ArranyM.
>>>
>>>
>>> Thanks!
>>>
>>> Do you want me to queue these for 3.8, or take them yourselves?
>>> In the latter case:
>>> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
>>
>>
>> I don't really mind either way. Happy for you to take them
>> if that is your preference.
>>
>> Same goes for the mm/init.c changes too. Happy for you to
>> take them if you want.
>
> I applied all of them to master, and queued them in for-3.8/for-next, so they
> will be picked up by tomorrow's linux-next, which is the last one before
> next-20121126.

Thanks!

Regards
Greg


------------------------------------------------------------------------
Greg Ungerer  --  Principal Engineer        EMAIL:     gerg@snapgear.com
SnapGear Group, McAfee                      PHONE:       +61 7 3435 2888
8 Gardner Close,                            FAX:         +61 7 3891 3630
Milton, QLD, 4064, Australia                WEB: http://www.SnapGear.com
