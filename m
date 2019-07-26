Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:48914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387777AbfGZNlu (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 26 Jul 2019 09:41:50 -0400
MIME-Version: 1.0
References: <cover.1564140865.git.mchehab+samsung@kernel.org> <430ed96cb234805d1deb216e8c8559da22cc6bac.1564140865.git.mchehab+samsung@kernel.org>
In-Reply-To: <430ed96cb234805d1deb216e8c8559da22cc6bac.1564140865.git.mchehab+samsung@kernel.org>
From: Rob Herring <robh+dt@kernel.org>
Date: Fri, 26 Jul 2019 07:41:35 -0600
Message-ID: <CAL_JsqK_rfHehrKW_NS89BOV0=dYoao0H=zOzG=D-724vKduKw@mail.gmail.com>
Subject: Re: [PATCH 1/7] docs: fix broken doc references due to renames
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc: "Paul E. McKenney" <paulmck@linux.ibm.com>, Josh Triplett <josh@joshtriplett.org>, Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, Joel Fernandes <joel@joelfernandes.org>, Jonathan Corbet <corbet@lwn.net>, Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Andrea Parri <andrea.parri@amarulasolutions.com>, Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, Akira Yokosawa <akiyks@gmail.com>, Daniel Lustig <dlustig@nvidia.com>, Jerry Hoemann <jerry.hoemann@hpe.com>, Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Ajay Gupta <ajayg@nvidia.com>, Don Brace <don.brace@microsemi.com>, "James E.J. Bottomley" <jejb@linux.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, rcu@vger.kernel.org, Linux Doc Mailing List <linux-doc@vger.kernel.org>, devicetree@vger.kernel.org, "open list:GENERIC INCLUDE/ASM HEADER FILES" <linux-arch@vger.kernel.org>, LINUX-WATCHDOG <linux-watchdog@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, Linux I2C <linux-i2c@vger.kernel.org>, esc.storagedev@microsemi.com, SCSI <linux-scsi@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>
Message-ID: <20190726134135.troHWpi8cQitO3DcB2MZSxC26VfQkZT1GhI8I4dUHFM@z>

On Fri, Jul 26, 2019 at 5:47 AM Mauro Carvalho Chehab
<mchehab+samsung@kernel.org> wrote:
>
> Some files got renamed but probably due to some merge conflicts,
> a few references still point to the old locations.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> Acked-by: Wolfram Sang <wsa@the-dreams.de> # I2C part
> Reviewed-by: Jerry Hoemann <jerry.hoemann@hpe.com> # hpwdt.rst
> ---
>  Documentation/RCU/rculist_nulls.txt                   |  2 +-
>  Documentation/devicetree/bindings/arm/idle-states.txt |  2 +-
>  Documentation/locking/spinlocks.rst                   |  4 ++--
>  Documentation/memory-barriers.txt                     |  2 +-
>  Documentation/translations/ko_KR/memory-barriers.txt  |  2 +-
>  Documentation/watchdog/hpwdt.rst                      |  2 +-
>  MAINTAINERS                                           | 10 +++++-----
>  drivers/gpu/drm/drm_modes.c                           |  2 +-
>  drivers/i2c/busses/i2c-nvidia-gpu.c                   |  2 +-
>  drivers/scsi/hpsa.c                                   |  4 ++--
>  10 files changed, 16 insertions(+), 16 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
