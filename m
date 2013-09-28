From: Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 0/3] New descriptor-based GPIO interface
Date: Sat, 28 Sep 2013 19:33:30 +0900
Message-ID: <CAAVeFuLfUGsmOssWDtm8kf9av=3A_O9Fk8M8HGYF=xqtX8772Q@mail.gmail.com>
References: <1380179668-32288-1-git-send-email-acourbot@nvidia.com> <CACRpkdbhywp7_wAhOSzdMe==YoCo0mAcy1mJrdW3bURKWLxQeQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CACRpkdbhywp7_wAhOSzdMe==YoCo0mAcy1mJrdW3bURKWLxQeQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Alexandre Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Mathias Nyman <mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
List-Id: linux-arch.vger.kernel.org

On Fri, Sep 27, 2013 at 9:06 PM, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> On Thu, Sep 26, 2013 at 9:14 AM, Alexandre Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote:
>
>> Here is a proper patch series for the descriptor-based GPIO interface to be
>> merged into -next. It is rebased on your for-next branch and only slightly
>> changed with respect to the RFC I posted earlier, only more thoroughly tested.
>> The documentation part is missing because I need some more time to rework it
>> (I'm on holidays this week but wanted to get the code into -next before 28th),
>> and anyway at this point I just want to make sure that the extra refactoring
>> does not break any existing code.
>>
>> My hope is to get this into -next before the 28th so this patchset can be
>> effectively tested, even if the new interfaces are not used yet. Since the old
>> integer-based interface now relies on top of gpiod_, this should provide good
>> coverage for both.
>
> I've applied it now, but no idea whether it will hit the last -next tree in
> time, hopefully at the very last second ...

Crap, looks like it did not make it. :( I hope we can still merge this for 3.13.

Alex.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
