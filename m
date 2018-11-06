From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH v2 3/4] sparc: add system call table generation support
Date: Mon, 05 Nov 2018 20:28:49 -0800 (PST)
Message-ID: <20181105.202849.1012263715606612557.davem@davemloft.net>
References: <1541080391-3890-4-git-send-email-firoz.khan@linaro.org>
        <20181101.133315.47887636039827313.davem@davemloft.net>
        <CAK8P3a0XOzuMxv5wJpd=jhronFJQ=PwCZ58VgxSkL_sSPV+CZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK8P3a0XOzuMxv5wJpd=jhronFJQ=PwCZ58VgxSkL_sSPV+CZQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: arnd@arndb.de
Cc: firoz.khan@linaro.org, sparclinux@vger.kernel.org, gregkh@linuxfoundation.org, pombredanne@nexb.com, tglx@linutronix.de, kstewart@linuxfoundation.org, y2038@lists.linaro.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, deepa.kernel@gmail.com, marcin.juszkiewicz@linaro.org
List-Id: linux-arch.vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 5 Nov 2018 11:48:43 +0100

> However, for all of those, I want the /format/ of the tables to be consistent
> so we can create the tooling around it to find and fix the issues. The work
> that Firoz is doing for now just makes sure that the /contents/ of the tables
> don't change at all, which is hard enough to do (the current version gets
> it all right afaict, but the previous versions missed some details).

Ok, agreed.
