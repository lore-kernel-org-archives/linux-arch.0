From: Arun R Bharadwaj <arun@linux.vnet.ibm.com>
Subject: [v7 PATCH 0/7]: cpuidle/x86/POWER: Cleanup idle power management
	code in x86, cleanup drivers/cpuidle/cpuidle.c and introduce
	cpuidle to POWER.
Date: Tue, 6 Oct 2009 20:54:21 +0530
Message-ID: <20091006152421.GA7278@linux.vnet.ibm.com>
Reply-To: arun@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@lists.ozlabs.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@lists.ozlabs.org
To: Peter Zijlstra <a.p.zijlstra@chello.nl>, Joel Schopp <jschopp@austin.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo>
Cc: linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Hi

Please consider this for inclusion into the testing tree.

This patchset introduces cpuidle infrastructure to POWER, prototyping
for pSeries, and also does a major refactoring of current x86 idle
power management and a cleanup of cpuidle infrastructure.

Earlier discussions on the same can be found at:

v6 --> http://lkml.org/lkml/2009/9/22/180
v5 --> http://lkml.org/lkml/2009/9/22/26
v4 --> http://lkml.org/lkml/2009/9/1/133
v3 --> http://lkml.org/lkml/2009/8/27/124
v2 --> http://lkml.org/lkml/2009/8/26/233
v1 --> http://lkml.org/lkml/2009/8/19/150


Changes in this version:
-----------------------------------------

* Earlier implementation maintained a list of cpuidle devices and
  the list was traversed to disable and enable the cpuidle devices
  when switching governors. This list is not necessary and is removed.
  Now, we get the per cpu structure cpuidle_devices and disable and
  enable it for each online cpu while switching governors.

* Earlier iterations were buggy w.r.t the sysfs interface of the cpuidle.
  This iteration removes the bug in PATCH 1/7.

* In PATCH 7/7, smt_snooze_delay was not being updated whenever it was
  changed through the sysfs interface. Provide a helper routine to
  update it.

* In PATCH 7/7, the idle loops are renamed to denote the idle states
  to avoid any confusion.


thanks,
arun
