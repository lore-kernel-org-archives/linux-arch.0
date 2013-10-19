From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v3 0/3] New descriptor-based GPIO interface
Date: Sat, 19 Oct 2013 23:26:58 +0200
Message-ID: <CACRpkdbpRkiANA32ZMEhm-XTB_FKCfmKQuGSmsD_0rLi96kPtQ@mail.gmail.com>
References: <1382030498-23465-1-git-send-email-acourbot@nvidia.com>
	<CACRpkdYx07Kfs6zOQmTg2cTSmEmsGgP=7wMCSG_30NW=dfYRPQ@mail.gmail.com>
	<CAAVeFu+rj6AtKgfig6ZrYUzW9HZTg5qLyw4aGozyD31P_pEKAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <CAAVeFu+rj6AtKgfig6ZrYUzW9HZTg5qLyw4aGozyD31P_pEKAQ@mail.gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Alexandre Courbot <gnurou@gmail.com>
Cc: Alexandre Courbot <acourbot@nvidia.com>, Arnd Bergmann <arnd@arndb.de>, Grant Likely <grant.likely@linaro.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Mathias Nyman <mathias.nyman@linux.intel.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Fri, Oct 18, 2013 at 7:37 PM, Alexandre Courbot <gnurou@gmail.com> wrote:
> On Fri, Oct 18, 2013 at 4:23 AM, Linus Walleij <linus.walleij@linaro.org> wrote:

>> We might have to take this as the first thing after the merge
>> window and targeted for v3.14.
>
> No particular pressure from my side to get this in 3.13. Do for the
> best, and don't hesitate to delay them to 3.14 if you feel they are
> not tested enough. I'll already feel better once I know they are under
> your tree. ;)

I applied it now anyway, I will try to also apply the ACPI stuff
making use of this interface and then throw it at the autobuild
to see what happens.

Yours,
Linus Walleij
