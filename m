From: Greentime Hu <green.hu@gmail.com>
Subject: Re: [PATCH v6 31/36] dt-bindings: nds32 CPU Bindings
Date: Mon, 22 Jan 2018 21:55:25 +0800
Message-ID: <CAEbi=3eyR4wqFDzZOfKk+EpvjQK5n8avDBxM50sde4P-_00q2w@mail.gmail.com>
References: <cover.1515766253.git.green.hu@gmail.com> <e9577ec0f6b6ca17077aa2f576c8bef191c3d7c2.1515766253.git.green.hu@gmail.com>
 <CAK8P3a0HGhx3WpF-AwC+7m8+FoaiQBTYoCLqhECrATBRLX7x5g@mail.gmail.com>
 <CAEbi=3ef8JHf_Jpru1B2L3+Xz-Oz4p_t84Lh=5kuTFo0YEz=5A@mail.gmail.com>
 <CAK8P3a38hCHULZt=fGXJebcoiEGCwA0fre_kixA7sUpPP2xf5g@mail.gmail.com>
 <CAEbi=3eexCyrVhFZB8wmK1fT=QONzc63y6=dGNgj_H+Rt4zo_g@mail.gmail.com>
 <CAMuHMdX4nzU06ovDOwzJw-O8w0gyer-fi6skDae=K1yr-EN1gA@mail.gmail.com>
 <CAEbi=3fKp5tj32hoH=ZTo6kqpCE+Zv1LopnpVujusSfMkeaJKg@mail.gmail.com>
 <CAMuHMdUqxuiTfM_m80F4XDVkZjx_XCsj_qXRehZxMcKjWhGQ_Q@mail.gmail.com>
 <CAEbi=3es7O6f5T0Z2zsQzbuxzNte+h-_fMnjOOvbvpz8Hu8g_Q@mail.gmail.com> <CAK8P3a2noraQFvJbi2=T+rb3KDfZ88zJWQ_h3dYjD2ArhLPM1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <CAK8P3a2noraQFvJbi2=T+rb3KDfZ88zJWQ_h3dYjD2ArhLPM1Q@mail.gmail.com>
Sender: netdev-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Greentime <greentime@andestech.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Networking <netdev@vger.kernel.org>, Vincent Chen <deanbo422@gmail.com>, DTML <devicetree@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>, Will Deacon <will.deacon@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-serial@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Greg KH <greg@kroah.com>, Guo Ren <ren_guo@c-sky.com>
List-Id: linux-arch.vger.kernel.org

Hi, Arnd:

2018-01-22 19:15 GMT+08:00 Arnd Bergmann <arnd@arndb.de>:
> On Mon, Jan 22, 2018 at 10:53 AM, Greentime Hu <green.hu@gmail.com> wrote:
>> 2018-01-19 23:37 GMT+08:00 Geert Uytterhoeven <geert@linux-m68k.org>:
>>> On Fri, Jan 19, 2018 at 4:35 PM, Greentime Hu <green.hu@gmail.com> wrote:
>>>> 2018-01-19 23:29 GMT+08:00 Geert Uytterhoeven <geert@linux-m68k.org>:
>>>>> On Fri, Jan 19, 2018 at 4:18 PM, Greentime Hu <green.hu@gmail.com> wrote:
>
>>>> Thank you and your example.
>>>> I get it. I will update this document like this.
>>>> - compatible: Should be "andestech,<core_name>", "andestech,nds32v3"
>>>> as fallback.
>>>
>>> And please keep a list of supported values of "andestech,<core_name>"
>>> in the DT binding document, so checkpatch can validate compatible values.
>>>
>>
>> Thank you for reminding me this.
>> I will list it like this.
>>
>> - compatible:
>>         Usage: required
>>         Value type: <string>
>>         Definition: Should be "andestech,<core_name>",
>> "andestech,nds32v3" as fallback.
>>         Examlpes with core_names are:
>>         "andestech,n13"
>>         "andestech,n15"
>>         "andestech,d15"
>>         "andestech,n10"
>>         "andestech,d10"
>
> This is still not written as a proper specification, you should not
> give "examples"
> but give a complete list of the available options. You could write it like:
>
> Must contain "andestech,nds32v3" as the most generic value, in addition to
> one of the following identifiers for a particular CPU core:
>          "andestech,n13"
>          "andestech,n15"
>          "andestech,d15"
>          "andestech,n10"
>          "andestech,d10"
>
> It might be helpful to also list all other existing nds32v3 cores,
> even those that the
> current Linux port does not support them.
>

Thank you for the clear explanation.
I will update it just like you wrote.
