Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41772 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725929AbeIFFKn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 6 Sep 2018 01:10:43 -0400
Received: by mail-wr1-f67.google.com with SMTP id z96-v6so9439980wrb.8
        for <linux-arch@vger.kernel.org>; Wed, 05 Sep 2018 17:38:02 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1536138304.git.ren_guo@c-sky.com> <aab0c4b467f69c693ed1e24e9fc47ba20b3f9f4a.1536138304.git.ren_guo@c-sky.com>
In-Reply-To: <aab0c4b467f69c693ed1e24e9fc47ba20b3f9f4a.1536138304.git.ren_guo@c-sky.com>
From: Rob Herring <rob.herring@linaro.org>
Date: Wed, 5 Sep 2018 19:37:50 -0500
Message-ID: <CABGGiszyQpJCB+QAoYwNwsDAhgdWQ3Ud1eR7U1xh9BMYzMKzjw@mail.gmail.com>
Subject: Re: [PATCH V3 18/26] dt-bindings: csky CPU Bindings
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: ren_guo@c-sky.com
Cc: linux-arch@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, Jason Cooper <jason@lakedaemon.net>, Arnd Bergmann <arnd@arndb.de>, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org, Greentime Hu <green.hu@gmail.com>
Message-ID: <20180906003750.2tgcHz925OyvMRG5-UIT5UH6LyIsckmipfAqIqyuz_8@z>

On Wed, Sep 5, 2018 at 7:08 AM Guo Ren <ren_guo@c-sky.com> wrote:
>
> Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> ---
>  Documentation/devicetree/bindings/csky/cpus.txt | 70 +++++++++++++++++++++++++
>  1 file changed, 70 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/csky/cpus.txt

Please make sure DT bindings are sent to DT list.

Thanks,
Rob
