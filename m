From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v4 4/6] tools: expand export.h with VMLINUX_SYMBOL()
Date: Thu, 19 Jan 2017 12:03:05 +0100
Message-ID: <20170119110305.GD28024@kroah.com>
References: <20170109150249.11667-1-mcgrof@kernel.org>
 <20170115211215.17216-1-mcgrof@kernel.org>
 <20170115211215.17216-5-mcgrof@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ia64-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170115211215.17216-5-mcgrof@kernel.org>
Sender: linux-ia64-owner@vger.kernel.org
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: bp@alien8.de, bp@suse.de, hpa@zytor.com, acme@redhat.com, tglx@linutronix.de, mingo@redhat.com, jpoimboe@redhat.com, npiggin@gmail.com, mhiramat@kernel.org, masami.hiramatsu.pt@hitachi.com, jbaron@akamai.com, heiko.carstens@de.ibm.com, ananth@linux.vnet.ibm.com, anil.s.keshavamurthy@intel.com, davem@davemloft.net, realmz6@gmail.com, dalias@libc.org, linux@arm.linux.org.uk, x86@kernel.org, luto@amacapital.net, keescook@chromium.org, linux@roeck-us.net, torvalds@linux-foundation.org, rusty@rustcorp.com.au, gnomes@lxorguk.ukuu.org.uk, alan@linux.intel.com, dwmw2@infradead.org, arnd@arndb.de, ming.lei@canonical.com, linux-arch@vger.kernel.org, benh@kernel.crashing.org, pebolle@tiscali.nl, fontana@sharpeleven.org, david.vrabel@citrix.com, konrad.wilk@oracle.com, mcb30@ipxe.org
List-Id: linux-arch.vger.kernel.org

On Sun, Jan 15, 2017 at 01:12:13PM -0800, Luis R. Rodriguez wrote:
> This will be used later by the linker-table userspace sandbox.

That does not explan what this is, why it is needed, or anything at all
:(

