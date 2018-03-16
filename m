From: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH 13/22] signal: Move addr_lsb into the _sigfault union for
 clarity
Date: Fri, 16 Mar 2018 12:24:44 -0700
Message-ID: <818f8945-f990-a770-476e-f82bdc77dbda@intel.com>
References: <87k1wimybi.fsf_-_@xmission.com>
 <20180116004009.31036-13-ebiederm@xmission.com>
 <29eb3438-0891-36ee-e5f6-36e26ccf2b89@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------E4E5380CCEAD534ACA4BA262"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <29eb3438-0891-36ee-e5f6-36e26ccf2b89@intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org, Ram Pai <linuxram@us.ibm.com>
List-Id: linux-arch.vger.kernel.org

This is a multi-part message in MIME format.
--------------E4E5380CCEAD534ACA4BA262
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

On 03/16/2018 12:00 PM, Dave Hansen wrote:
> On 01/15/2018 04:40 PM, Eric W. Biederman wrote:
>> The addr_lsb fields is only valid and available when the
>> signal is SIGBUS and the si_code is BUS_MCEERR_AR or BUS_MCEERR_AO.
>> Document this with a comment and place the field in the _sigfault union
>> to make this clear.
>>
>> All of the fields stay in the same physical location so both the old
>> and new definitions of struct siginfo will continue to work.
> 
> This breaks the ABI and breaks protection keys.  The physical locations
> *DO* change.
> 
> Before this patch:
> 
> #define si_pkey         _sifields._sigfault._pkey
> (gdb) print &((siginfo_t *)0)->_sifields._sigfault._pkey
> $1 = (__u32 *) 0x20 <irq_stack_union+32>
> 
> and after:
> 
> +#define si_pkey                _sifields._sigfault._addr_pkey._pkey
> (gdb) print &((siginfo_t *)0)->_sifields._sigfault._addr_pkey._pkey
> $1 = (__u32 *) 0x1c
> 
> Can we revert this, please?

It does not revert cleanly so I reverted it manually.  Patch doing that
is attached.  Should we do this, or is there a better option?

--------------E4E5380CCEAD534ACA4BA262
Content-Type: text/x-patch;
 name="revert-b68a68d3dcc15ebbf23cbe91af1abf57591bd96b.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="revert-b68a68d3dcc15ebbf23cbe91af1abf57591bd96b.patch"


index e698ec1..8f8e3ef 100644

---

 b/include/linux/compat.h             |   12 ++----------
 b/include/uapi/asm-generic/siginfo.h |   14 +++-----------
 2 files changed, 5 insertions(+), 21 deletions(-)

diff -puN include/linux/compat.h~revert-b68a68d3dcc15ebbf23cbe91af1abf57591bd96b include/linux/compat.h
--- a/include/linux/compat.h~revert-b68a68d3dcc15ebbf23cbe91af1abf57591bd96b	2018-03-16 12:02:22.156310058 -0700
+++ b/include/linux/compat.h	2018-03-16 12:03:11.341309936 -0700
@@ -222,23 +222,15 @@ typedef struct compat_siginfo {
 #ifdef __ARCH_SI_TRAPNO
 			int _trapno;	/* TRAP # which caused the signal */
 #endif
+			short int _addr_lsb;	/* Valid LSB of the reported address. */
 			union {
-				/*
-				 * used when si_code=BUS_MCEERR_AR or
-				 * used when si_code=BUS_MCEERR_AO
-				 */
-				short int _addr_lsb;	/* Valid LSB of the reported address. */
 				/* used when si_code=SEGV_BNDERR */
 				struct {
-					compat_uptr_t _dummy_bnd;
 					compat_uptr_t _lower;
 					compat_uptr_t _upper;
 				} _addr_bnd;
 				/* used when si_code=SEGV_PKUERR */
-				struct {
-					compat_uptr_t _dummy_pkey;
-					u32 _pkey;
-				} _addr_pkey;
+				u32 _pkey;
 			};
 		} _sigfault;
 
diff -puN include/uapi/asm-generic/siginfo.h~revert-b68a68d3dcc15ebbf23cbe91af1abf57591bd96b include/uapi/asm-generic/siginfo.h
--- a/include/uapi/asm-generic/siginfo.h~revert-b68a68d3dcc15ebbf23cbe91af1abf57591bd96b	2018-03-16 12:02:22.157310058 -0700
+++ b/include/uapi/asm-generic/siginfo.h	2018-03-16 12:03:37.071309872 -0700
@@ -94,23 +94,15 @@ typedef struct siginfo {
 			unsigned int _flags;	/* see ia64 si_flags */
 			unsigned long _isr;	/* isr */
 #endif
+			short _addr_lsb; /* LSB of the reported address */
 			union {
-				/*
-				 * used when si_code=BUS_MCEERR_AR or
-				 * used when si_code=BUS_MCEERR_AO
-				 */
-				short _addr_lsb; /* LSB of the reported address */
 				/* used when si_code=SEGV_BNDERR */
 				struct {
-					void *_dummy_bnd;
 					void __user *_lower;
 					void __user *_upper;
 				} _addr_bnd;
 				/* used when si_code=SEGV_PKUERR */
-				struct {
-					void *_dummy_pkey;
-					__u32 _pkey;
-				} _addr_pkey;
+				__u32 _pkey;
 			};
 		} _sigfault;
 
@@ -150,7 +142,7 @@ typedef struct siginfo {
 #define si_addr_lsb	_sifields._sigfault._addr_lsb
 #define si_lower	_sifields._sigfault._addr_bnd._lower
 #define si_upper	_sifields._sigfault._addr_bnd._upper
-#define si_pkey		_sifields._sigfault._addr_pkey._pkey
+#define si_pkey		_sifields._sigfault._pkey
 #define si_band		_sifields._sigpoll._band
 #define si_fd		_sifields._sigpoll._fd
 #define si_call_addr	_sifields._sigsys._call_addr
_

--------------E4E5380CCEAD534ACA4BA262--
