From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: __HAVE_ARCH_CMPXCHG on ARM?
Date: Wed, 18 Feb 2015 11:44:59 +0100
Message-ID: <20150218104459.GD28763@linutronix.de>
References: <20150129185618.GA31459@nathan3500-linux-VM>
 <CAM2zO=CVCZFNiSukgcgNNT0==xgLK4w5HF3Pz=dcFmrEHPtLdw@mail.gmail.com>
 <20150202133933.GD31847@arm.com>
 <20150203192730.GA10759@jcartwri.amer.corp.natinst.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-rt-users-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150203192730.GA10759@jcartwri.amer.corp.natinst.com>
Sender: linux-rt-users-owner@vger.kernel.org
To: Josh Cartwright <joshc@ni.com>
Cc: Will Deacon <will.deacon@arm.com>, Yong Zhang <yong.zhang0@gmail.com>, Yong Zhang <yong.zhang@windriver.com>, Nathan Sullivan <nathan.sullivan@ni.com>, linux-rt-users <linux-rt-users@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

* Josh Cartwright | 2015-02-03 13:27:30 [-0600]:

>                 native         native
>                cmpxchg (UP)   cmpxchg (SMP)    __HAVE_ARCH_CMPXCHG
>         xtensa     X               X

This one does not always have cmpxchg on UP (only the SMP variant which
provides atomic operation).

>  Josh

Sebastian
