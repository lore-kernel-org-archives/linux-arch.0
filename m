From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC v2 7/7] kprobes: port to linker table
Date: Fri, 19 Feb 2016 14:15:11 +0000
Message-ID: <20160219141511.GX19428@n2100.arm.linux.org.uk>
References: <1455889559-9428-1-git-send-email-mcgrof@kernel.org>
 <1455889559-9428-8-git-send-email-mcgrof@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1455889559-9428-8-git-send-email-mcgrof@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: hpa@zytor.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org, linux-kernel@vger.kernel.org, luto@amacapital.net, boris.ostrovsky@oracle.com, rusty@rustcorp.com.au, david.vrabel@citrix.com, konrad.wilk@oracle.com, mcb30@ipxe.org, jgross@suse.com, ming.lei@canonical.com, gregkh@linuxfoundation.org, arnd@arndb.de, linux-arch@vger.kernel.org, benh@kernel.crashing.org, jbaron@akamai.com, ananth@in.ibm.com, anil.s.keshavamurthy@intel.com, davem@davemloft.net, masami.hiramatsu.pt@hitachi.com, andriy.shevchenko@linux.intel.com, dwmw2@infradead.org, xen-devel@lists.xensource.com
List-Id: linux-arch.vger.kernel.org

On Fri, Feb 19, 2016 at 05:45:59AM -0800, Luis R. Rodriguez wrote:
> kprobe makes use of two custom sections:
> 
> type       name                  begin                    end
> init.data _kprobe_blacklist __start_kprobe_blacklist	__stop_kprobe_blacklist
> text      .kprobes.text     __kprobes_text_start        __kprobes_text_end
> 
> Port these to the linker table generic solution. This lets
> us remove all the custom kprobe section declarations on the
> linker script.

I don't like this.  You create this "table" thing, which you use for
tables, and then you go and use it for something else - for kprobes
text which is not a table.  The kprobes text section is a section for
text which is not kprobe-able.

So, it seems to be a complete mis-nomer to me.  Maybe you can explain
the rationale here?

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
