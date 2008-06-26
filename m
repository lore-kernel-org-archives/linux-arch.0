From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 59/60] microblaze_v4: syscall_table.S and unistd.h
Date: Thu, 26 Jun 2008 10:02:02 -0700
Message-ID: <4863CB8A.7000204@zytor.com>
References: <1214483429-32360-1-git-send-email-monstr@seznam.cz>
	<1214483429-32360-59-git-send-email-monstr@seznam.cz>
	<1214483429-32360-60-git-send-email-monstr@seznam.cz>
	<200806261831.19187.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org>
In-Reply-To: <200806261831.19187.arnd@arndb.de>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, alan@lxorguk.ukuu.org.uk, Michal Simek <monstr@monstr.eu>, vapier.adi@gmail.com, matthew@wil.cx, microblaze-uclinux@itee.uq.edu.au, linux-kernel@vger.kernel.org, drepper@redhat.com, linuxppc-dev@ozlabs.org, will.newton@gmail.com, monstr@seznam.cz, John.Linn@xilinx.com, john.williams@petalogix.com
List-Id: linux-arch.vger.kernel.org

Arnd Bergmann wrote:
> 
> You still set __NR_fork. There is no point defining the number if you
> can't actually call the syscall in the first place.
> 

Worse, it is actively *harmful* to set the number; klibc or anything 
that uses similar kinds of scripts for portability will see the symbol 
and think the system call is available.

	-hpa
