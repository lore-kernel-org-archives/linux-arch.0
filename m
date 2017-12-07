From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [PATCH v2 08/35] nds32: Process management
Date: Thu, 7 Dec 2017 16:45:06 +0000
Message-ID: <20171207164506.GE21978@ZenIV.linux.org.uk>
References: <cover.1511785528.git.green.hu@gmail.com>
 <53789f9af98217d24580479c55e550301651d4a8.1511785528.git.green.hu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <53789f9af98217d24580479c55e550301651d4a8.1511785528.git.green.hu@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greentime Hu <green.hu@gmail.com>
Cc: greentime@andestech.com, linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, robh+dt@kernel.org, netdev@vger.kernel.org, deanbo422@gmail.com, devicetree@vger.kernel.org, dhowells@redhat.com, will.deacon@arm.com, daniel.lezcano@linaro.org, linux-serial@vger.kernel.org, Vincent Chen <vincentc@andestech.com>
List-Id: linux-arch.vger.kernel.org

On Mon, Nov 27, 2017 at 08:27:55PM +0800, Greentime Hu wrote:

> +#define start_thread(regs,pc,stack)			\
> +({							\
> +	set_fs(USER_DS);				\

Not the job of start_thread() - its users (->load_binary() methods of
assorted binfmt) must (and do) call flush_old_exec() first.  And
that will switch to USER_DS just fine.
